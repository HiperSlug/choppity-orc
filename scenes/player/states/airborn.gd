extends State

func _can_enter() -> bool:
	return not character.is_on_floor()

func _enter() -> void:
	sprite.play("jump",0)

func _do(delta : float) -> void:
	character.velocity.y += character.gravity * delta
	if character.velocity.y < -100:
		sprite.frame = 0
	elif character.velocity.y > 100:
		sprite.frame = 2
	else:
		sprite.frame = 1
