extends State

var chain : Line2D

func _can_enter() -> bool:
	return $"..".state.name != "Swing" 

func _enter() -> void:
	print("enter Idle")

func _exit() -> void:
	pass

func _do(_delta : float) -> void:
	if Input.is_action_just_pressed("temp_action"):
		leave.emit("Swing")
