extends Projectile


var direction : Vector2:
	get:
		return velocity.normalized()
const THROW_SPEED : int = 500
const GRAVITY : int = int(980 * .75)

signal destroyed(projectile)

func destroy() -> void:
	destroyed.emit(self)
	queue_free()


func _physics_process(_delta: float) -> void:
	rotation = direction.angle()
	
	#chain_link_stuff()

#var chain_link_scene : PackedScene = preload("res://scenes/projectiles/chain_knife/chain_link.tscn")
var last_chain_link : PinJoint2D
#func chain_link_stuff() -> void:
	#var displacement : Vector2 = get_tree().get_nodes_in_group("player")[0].global_position - global_position
	#var direction : Vector2 = displacement.normalized()
	#var chain_links_needed : int = int(displacement.length()/10)
	#var chain_links_had : int = $Chain.get_child_count()
#
	#for i in range(chain_links_needed-chain_links_had):
		##var c : PinJoint2D = chain_link_scene.instantiate()
		#if last_chain_link == null:
			#c.node_a = "../.."
		#else:
			#c.globaltransform = last_chain_link.get_child(0).global_transform
			#c.node_a = "../" + last_chain_link.name + "/RigidBody2D"
		#c.direction = direction
		#$Chain.add_child(c)
		#last_chain_link = c
