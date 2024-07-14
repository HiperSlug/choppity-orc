extends State # extend state machine to handle child states

var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

func _can_enter() -> bool:
	return not character.is_on_floor()

func _can_exit() -> bool:
	return true

func _enter() -> void:
	sprite.play("jump",0)
	super()

func _exit() -> void:
	super()

func _do(delta : float) -> void:
	character.velocity.y += gravity * delta
	if character.velocity.y < -100:
		sprite.frame = 0
	elif character.velocity.y > 100:
		sprite.frame = 2
	else:
		sprite.frame = 1
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
