extends Area2D
class_name LoadingZone

@export var next_level : PackedScene

func _on_body_entered(_body: Player) -> void:
	if next_level != null:
		get_tree().call_deferred("change_scene_to_packed",next_level)
	else:
		print("next_level error")
