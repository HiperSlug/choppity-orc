extends StateMachine # extend state machine to handle child states

#region State Defaults
func _can_enter() -> bool:
	return true

func _can_exit() -> bool:
	return true

func _enter() -> void:
	super()

func _exit() -> void:
	super()

func _physics_do(delta : float) -> void:
	super(delta)

func _do(delta : float) -> void:
	super(delta)
#endregion

func _try_leave() -> void: #super._do() calls this every frame
	pass

func _on_throw_hit() -> void:
	leave.emit(sibling_dictionary["Lodged"])
