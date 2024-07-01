extends State

func _can_enter() -> bool:
	return abs(character.velocity.x) > 0

func _enter() -> void:
	sprite.play("run")
