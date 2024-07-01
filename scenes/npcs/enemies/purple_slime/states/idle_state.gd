extends State

func _can_enter() -> bool:
	return true

func _can_exit() -> bool:
	return true

func _enter() -> void:
	print("idle entered")

func _exit() -> void:
	print("idle exited")

func _do(delta : float) -> void:
	print("idle do")
