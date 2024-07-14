extends State

const SPEED : int = 500

func _enter() -> void:
	character.velocity = SPEED * character.direction * Vector2.RIGHT

func _do(delta : float) -> void:
	
	if character.test_move(character.transform,SPEED * character.direction * delta * Vector2.RIGHT) == true:
		character.move_and_slide()
		leave.emit("Lodged")
	
	character.move_and_slide()
	sprite.rotation += 3 * delta * PI * 2
	
