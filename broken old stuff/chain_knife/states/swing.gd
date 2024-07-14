extends State

var chain : Line2D
const PULL_SPEED : int = 350

var max_chain_length : float


#func _enter() -> void:
	#var spring_joint : Bob = spring_projectile.throw_projectile((get_tree().get_nodes_in_group("player")[0].global_position - character.global_position).normalized())
	#spring_joint.connect_joint(character)

var PULL_CONSTANT : int = 1


@export var spring_projectile : ProjectileSpawner
func _do(_delta : float) -> void:	
	#var displacement : Vector2 = (chain.points[0] - chain.points[1])
	#if displacement.length() > max_chain_length:
		#var direction : Vector2 = displacement.normalized()
		#var length_difference: float = displacement.length() - max_chain_length
		#var old_velocity : Vector2 = get_tree().get_nodes_in_group("player")[0].velocity
		#get_tree().get_nodes_in_group("player")[0].velocity += length_difference * direction * PULL_CONSTANT
		#get_tree().get_nodes_in_group("player")[0].move_and_slide()
		#get_tree().get_nodes_in_group("player")[0].velocity.y = move_toward(get_tree().get_nodes_in_group("player")[0].velocity.y,0,100)


	if Input.is_action_just_released("temp_action"):
		var direction : Vector2 = (get_tree().get_nodes_in_group("player")[0].global_position - character.global_position).normalized()
		get_tree().get_nodes_in_group("player")[0].velocity = PULL_SPEED * direction * -1
		get_tree().get_nodes_in_group("player")[0].move_and_slide()
		leave.emit("Idle")
