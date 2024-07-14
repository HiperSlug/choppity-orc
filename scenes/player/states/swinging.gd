extends State # extend state machine to handle child states

var chain_axe : CharacterBody2D
func _on_chain_axe_spawner_spawned(spawn: CharacterBody2D) -> void:
	chain_axe = spawn


@export var floor_timer : Timer
func _can_enter() -> bool:
	var chain_axe_is_lodged : bool
	if chain_axe != null:
		var chain_axe_state = chain_axe.get_node("RootStateMachine").get_active_state_tree()[-1]
		chain_axe_is_lodged = chain_axe_state.name == "Lodged"
	var input_is_pressed : bool = Input.is_action_just_pressed("primary")
	var not_on_floor : bool = floor_timer.is_stopped()
	return chain_axe_is_lodged and input_is_pressed and not_on_floor

func _can_exit() -> bool:
	return not floor_timer.is_stopped() or Input.is_action_just_released("primary")

func _enter() -> void:
	max_dist = (character.global_position - chain_axe.global_position).length()
	print("Enter Swinging")
	super()

func _exit() -> void:
	print("Exit Swinging")
	super()

var max_dist : float
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")
var dir : Vector2
func _do(delta : float) -> void:
	character.velocity.y += gravity * delta
	dir = (chain_axe.global_position - character.global_position).normalized().rotated(character.velocity.normalized().angle())
	add_normal_acceleration(delta) # idk if this is the right term
	if character.move_and_collide(character.velocity * delta) != null:
		character.velocity = Vector2i(character.velocity * -.5)
	
	var dir : float = Input.get_axis("left","right")
	super(delta)
	

func add_normal_acceleration(delta) -> void:
	var character_direction : Vector2 = character.velocity.normalized()
	var direction_rotated : Vector2 = (chain_axe.global_position - character.global_position).normalized().rotated(PI /2)
	

	character.velocity = direction_rotated * character.velocity.length()
	
	var centripital_acceleration : Vector2 = (character.velocity *character.velocity) / max_dist
	centripital_acceleration = centripital_acceleration.rotated(-PI * .5)

	character.velocity += centripital_acceleration *  delta
	

func _physics_do(delta : float) -> void:
	super(delta)

func _try_leave() -> void: #super._do() calls this every frame
	for sibling in sibling_states:
		if not sibling in go_to_exceptions:
			if sibling._can_enter():
				if sibling == self:
					break
				leave.emit(sibling)
