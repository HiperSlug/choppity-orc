extends Node
class_name State

#region Variables and such
@export_category("nodes")
@export var character : CharacterBody2D
@export var sprite : Node2D
<<<<<<< Updated upstream
signal leave(new_state_name : String)
=======
var is_active: bool = false
var sibling_states : Array[Node] # set in statemachine
var sibling_dictionary : Dictionary
signal leave(new_state_name : State)
#endregion
>>>>>>> Stashed changes

#region Can Enter/Exit
func _can_enter() -> bool:
	return true

func _can_exit() -> bool:
	return true
#endregion

#region On Enter/Exit
func _enter() -> void:
	is_active = true

func _exit() -> void:
	is_active = false
#endregion

#region Do's
func _do(_delta : float) -> void:
	if _can_exit():
		_try_leave()

func _physics_do(_delta : float) -> void:
	pass
#endregion

#region Exit Logic
@export var go_to_exceptions : Array[Node]

func _try_leave() -> void: #super._do() calls this every frame
	for sibling in sibling_states:
		if not sibling in go_to_exceptions:
			if sibling._can_enter():
				if sibling == self:
					break
				leave.emit(sibling)
#endregion
