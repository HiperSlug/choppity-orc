extends State # extend state machine to handle child states


func _can_enter() -> bool:
	return abs(character.velocity.x) > 0

func _can_exit() -> bool:
	return true

func _enter() -> void:
	sprite.play("run")
	super()

func _exit() -> void:
	super()

func _do(delta : float) -> void:
	super(delta)

func _physics_do(delta : float) -> void:
	super(delta)

func _try_leave() -> void: #super._do() calls this every frame
	for sibling in sibling_states:
		if not sibling in go_to_exceptions:
			if sibling._can_enter():
				if sibling == self:
					break
				leave.emit(sibling)
