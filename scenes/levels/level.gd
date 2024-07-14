extends Node2D
class_name Level

func _ready() -> void:
	get_tree().get_nodes_in_group("player")[0].connect("shoot_axe",on_player_shoot_axe)

<<<<<<< Updated upstream
func on_player_shoot_axe(axe : Axe) -> void:
	$Projectile.add_child(axe)
=======
func on_spawner_spawned(spawn : Node) -> void:
	$Projectile.add_child(spawn)

func connect_spawner(spawner : Spawner) -> void:
	spawner.connect("spawned",on_spawner_spawned)
>>>>>>> Stashed changes
