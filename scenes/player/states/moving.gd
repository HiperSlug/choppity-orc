extends StateMachine # extend state machine to handle child states

#region Timers
@export var jump_pressed_timer: Timer
@export var is_on_floor_timer: Timer
#endregion

#region Non-movement Input

@export var chain_axe_spawner: Spawner
func _unhandled_input(event: InputEvent):
	if event is InputEventMouseMotion:
		return 
	
	#region Jump
	if event.is_action_pressed("jump"):
		jump_pressed_timer.start()
	#endregion
	
	#region Projectile
	if event.is_action_pressed("primary"):
		var throw_direction : Vector2 = (character.get_global_mouse_position() - character.global_position).normalized()
		var spawn_details : SpawnDetails = SpawnDetails.new(1)
		spawn_details.properties[0] = {
			"name" = "direction",
			"value" = throw_direction,
		} 
		chain_axe_spawner.spawn(spawn_details)
	#endregion
#endregion


#region Movement
const JUMP_VELOCITY : float = -400.0
const max_speed : int = 200
var movement_ratio: Vector2

var is_on_floor: bool:
	get:
		return not is_on_floor_timer.is_stopped()
var jump_pressed: bool:
	get:
		return not jump_pressed_timer.is_stopped()

var direction : float = 1:
	set(value):
		if value != 0:
			direction = value
			character.scale.y = direction
			character.rotation = PI * (direction-1) * .5

func _do(delta : float) -> void:
	#region Jumping
	if jump_pressed and is_on_floor:
		jump_pressed_timer.stop()
		is_on_floor_timer.stop()
		
		character.velocity.y = JUMP_VELOCITY
	
	if Input.is_action_just_released("jump"):
		if character.velocity.y < 0:
			character.velocity.y *= .5
	#endregion
	
	#region Movement
	var dir = Input.get_axis("left", "right")
	
	if is_on_floor:
		movement_ratio = Vector2.ONE
	else:
		movement_ratio = Vector2(.5,.5)
	
	
	if dir != 0:
		var acceleration: int
		
		if dir != sign(character.velocity.x):
			acceleration = int( max_speed * .1 )
		else:
			acceleration  = int( (max_speed-abs(character.velocity.x)) * .1 )
		
		if max_speed >= abs((acceleration * movement_ratio.x * dir) + character.velocity.x):
			character.velocity.x += dir * acceleration * movement_ratio.x
	else:
		var amount : int = int( max_speed * .1  * movement_ratio.x)
		character.velocity.x = move_toward(character.velocity.x, 0 , amount) 
	
	direction = dir
	character.move_and_slide()
	
	super(delta)
	#endregion

#endregion

#region Default State functions
func _can_enter() -> bool:
	return true

func _can_exit() -> bool:
	return true

func _enter() -> void:
	super()

func _exit() -> void:
	super()

func _physics_do(delta : float) -> void:
	super(delta)

func _try_leave() -> void: #super._do() calls this every frame
	for sibling in sibling_states:
		if not sibling in go_to_exceptions:
			if sibling._can_enter():
				if sibling == self:
					break
				leave.emit(sibling)
#endregion
