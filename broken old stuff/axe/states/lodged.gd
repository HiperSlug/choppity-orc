extends State

@export var bounce_area : Area2D

func _enter() -> void:
	character.velocity = Vector2.ZERO
	sprite.rotation = 0

func _do(_delta : float) -> void:
	for body in bodies_in_area:
		if body.velocity.y >= 0:
			body.velocity.y = body.JUMP_VELOCITY * 1.25
	if Input.is_action_just_pressed("action"):
		leave.emit("Return")

var bodies_in_area : Array = []
func _on_bounce_area_body_entered(body: Player) -> void:
	if not body in bodies_in_area:
		bodies_in_area.append(body)

func _on_bounce_area_body_exited(body: Player) -> void:
	if body in bodies_in_area:
		bodies_in_area.erase(body)
