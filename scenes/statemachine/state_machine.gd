extends State
class_name StateMachine

@export var dynamic_state_updates : bool = true
var state : State
var child_states : Dictionary = {}

func _ready() -> void:
	for state_node in get_children():
		
		child_states[state_node.name] = {
			"priority" = state_node.priority,
			"node" = state_node,
		}
		
		if state_node.character == null:
			state_node.character = character
		if state_node.sprite == null:
			state_node.sprite = sprite
		
		state_node.connect("leave",state_leave)
		
	switch_states(get_best_state())

func _physics_process(delta: float) -> void:
	if dynamic_state_updates:
		if state._can_exit():
			var best_state : State = get_best_state()
			if best_state != state:
				switch_states(best_state)	
	state._do(delta)

func get_best_state() -> State:
	var highest_priority
	for state_key in child_states:
		
		if child_states[state_key]["node"]._can_enter() == true:
			
			if highest_priority == null or child_states[highest_priority]["priority"] < child_states[state_key]["priority"]:
				highest_priority = state_key
	
	return child_states[highest_priority]["node"]

func switch_states(new_state : State) -> void:
	if state != null:
		state._exit()
	state = new_state
	state._enter()

func state_leave(new_state : String) -> void:
	if new_state != null:
		switch_states(child_states[new_state]["node"])
	else:
		switch_states(get_best_state())
