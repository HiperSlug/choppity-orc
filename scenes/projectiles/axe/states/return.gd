extends State

const SPEED : int = 400
@export var collision_shape : CollisionShape2D

func _enter() -> void:
	collision_shape.disabled = true

func _do(delta : float) -> void:
	var direction = (character.global_position-get_tree().get_nodes_in_group("player")[0].global_position).normalized()

	character.velocity = direction * SPEED * -1

	if abs(character.global_position-get_tree().get_nodes_in_group("player")[0].global_position) < abs(character.velocity * delta):
		character.call_deferred("destroy")

	character.move_and_slide()
	sprite.rotation -= 3 * delta * PI * 2
