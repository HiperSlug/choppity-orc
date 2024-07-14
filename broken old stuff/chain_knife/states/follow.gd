extends State

var speed : float = 500

func _can_enter() -> bool:
	return false

func _do(delta : float) -> void:
	var displacement : Vector2 = (character.get_global_mouse_position() - character.global_position)
	character.velocity = displacement * speed * delta
	character.move_and_slide()
	
	character.rotation = displacement.normalized().angle()
