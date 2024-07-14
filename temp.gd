extends State


func _can_enter() -> bool:
	return true

func _can_exit() -> bool:
	return true

func _enter() -> void:
	super()

func _exit() -> void:
	super()

func _do(delta : float) -> void:
	super(delta)

func _physics_do(delta : float) -> void:
	super(delta)

func _try_leave() -> void: #called in _do() in super class
	for sibling in sibling_states:
		if not sibling in go_to_exceptions:
			if sibling == self:
				break
			elif sibling._can_enter():
				leave.emit(sibling)
