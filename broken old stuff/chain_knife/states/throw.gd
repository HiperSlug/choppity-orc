extends State

@export var trail : Line2D
@export var trail_timer : Timer
func _enter() -> void:
	print("enter Throw")
	character.velocity = (character.get_global_mouse_position()-character.global_position).normalized() * character.THROW_SPEED
	trail.add_point(character.position)
	trail_timer.start()

func _exit() -> void:
	pass

func _do(delta : float) -> void:
	do_trail()
	
	if character.test_move(character.transform,character.velocity * delta) == true:
		
		character.move_and_collide(character.velocity * delta)
		leave.emit("Lodge")
	
	character.velocity.y += character.GRAVITY * delta
	character.move_and_collide(character.velocity * delta)
	
func do_trail() -> void:
	trail.add_point(character.global_position)


func _on_timer_timeout() -> void:
	if trail.points.size() > 0:
		trail.remove_point(0)
		for point in range(trail.points.size() / 10):
			trail.remove_point(point)
	else:
		trail_timer.stop()
