extends StateMachine

@export var chain : Line2D:
	set(value):
		chain = value
		for child in get_children():
			child.chain = chain

func _enter() -> void:
	chain.add_point(character.position)
	chain.add_point(get_tree().get_nodes_in_group("player")[0].global_position)
	super()

func _do(delta : float) -> void:
	chain.points[0] = character.position
	chain.points[1] = get_tree().get_nodes_in_group("player")[0].global_position
	super(delta)
	

#func state_leave(new_state : String) -> void:
	#if state.name == "Swing":
		#leave.emit("Return")
	#super(new_state)
