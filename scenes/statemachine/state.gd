extends Node
class_name State

@export_category("variables")
@export var priority : int
@export_category("nodes")
@export var character : CharacterBody2D
@export var sprite : Node2D
signal leave(new_state_name : String)

func _can_enter() -> bool:
	return true

func _can_exit() -> bool:
	return true

func _enter() -> void:
	pass

func _exit() -> void:
	pass

func _do(_delta : float) -> void:
	pass
