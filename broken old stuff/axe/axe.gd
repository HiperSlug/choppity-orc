extends CharacterBody2D
class_name Axe

var direction : float

signal returned()
func destroy() -> void:
	returned.emit()
	queue_free()

func _ready() -> void:
	scale.x = direction
