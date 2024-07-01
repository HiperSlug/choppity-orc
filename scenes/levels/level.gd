extends Node2D
class_name Level

func _ready() -> void:
	get_tree().get_nodes_in_group("player")[0].connect("shoot_axe",on_player_shoot_axe)

func on_player_shoot_axe(axe : Axe) -> void:
	$Projectile.add_child(axe)
