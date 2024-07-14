extends State
class_name StateMachine

<<<<<<< Updated upstream
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
=======
func _ready() -> void:
	init_children_dictionary()
	init_sibling_states()

	for child in children:
		child.connect("leave",on_state_leave)

	active_state = inital_state

#region Sibling States
func init_sibling_states() -> void:
	for child in children:
		child.sibling_states = children
	for child in children:
		child.sibling_dictionary = children_dictionary
#endregion

#region Children Variables
@onready var children : Array[Node] = get_children()
var children_dictionary : Dictionary

func init_children_dictionary() -> void:
	for child in children:
		children_dictionary[child.name] = child
#endregion

#region Switching States
func on_state_leave(new_state : State) -> void:
	set_state(new_state)

func set_state(new_state : State) -> void:
	active_state._exit()
	active_state = new_state
	active_state._enter()
#endregion

#region State Logic
var active_state : State
@export var inital_state : State

func _do(delta : float) -> void:
	active_state._do(delta)
	super(delta)

func _physics_do(delta : float) -> void:
	active_state._physics_do(delta)
	super(delta)
#endregion

#region Variable Inheritance
func push_vars_on_children(override : bool) -> void:
	if override:
		for child in children:
			child.character = self.character
			child.sprite = self.sprite
			
			if child is StateMachine:
				child.push_vars_on_children(override)
	else:
		for child in children:
			if child.character == null:
				child.character = self.character
			if child.sprite == null:
				child.sprite = self.sprite
			
			if child is StateMachine:
				child.push_vars_on_children(override)
#endregion

#region Enter and Exit
func _enter() -> void:
	active_state._enter()
	is_active = true

func _exit() -> void:
	active_state._exit()
	is_active = false
#endregion

>>>>>>> Stashed changes
