extends StateMachine
class_name RootStateMachine

@export var override_child_vars : bool = false

func _ready() -> void:
	push_vars_on_children(override_child_vars)
	super()
	_enter()

func _process(delta: float) -> void:
	self._do(delta)

func _physics_process(delta: float) -> void:
	self._physics_do(delta)

func get_active_state_tree() -> Array[State]:
	var active_state_tree : Array[State]
	active_state_tree.append(active_state)
	var iterating_active_state : State = active_state
	
	while iterating_active_state is StateMachine:
		active_state_tree.append(iterating_active_state.active_state)
		iterating_active_state = iterating_active_state.active_state
	return active_state_tree
