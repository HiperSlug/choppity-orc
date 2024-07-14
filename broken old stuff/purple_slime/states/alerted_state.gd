extends State

@export var alert_area : Area2D

func _can_enter() -> bool:
	return alert_area.bodies.size() > 0

func _can_exit() -> bool:
	return true

func _enter() -> void:
	print("alert entered")

func _exit() -> void:
	print("alert exited")

func _do(delta : float) -> void:
	print("alert do")
