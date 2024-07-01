extends CharacterBody2D
class_name Player



func death(_area : Area2D) -> void:
	get_tree().call_deferred("reload_current_scene")

var can_axe : bool = true
var axe_scene : PackedScene = preload("res://scenes/projectiles/axe/axe.tscn")
var active_axe : Axe
signal shoot_axe(axe)

func _unhandled_key_input(event: InputEvent) -> void: # Jump  and Axe input
	if event.is_action_pressed("jump"):
		$JumpPressedTimer.start()

	if event.is_action_pressed("action"):
		if can_axe:
			throw_axe()
		else:
			await active_axe.returned
			can_axe = true

func throw_axe() -> void:
	var a : Axe = axe_scene.instantiate()
	a.global_position = global_position
	a.global_position.y -= 8
	a.direction = direction
	active_axe = a
	shoot_axe.emit(a)
	can_axe = false

# MOVEMENT

const SPEED : int = 130
const JUMP_VELOCITY : float = -310.0
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction : float = 1:
	set(value):
		if value != 0:
			direction = value
			self.scale.y = direction
			self.rotation = PI * (direction-1) * .5

func _process(_delta: float) -> void:
	if is_on_floor():
		$CoyoteJumpTimer.start()
	if not $JumpPressedTimer.is_stopped() and not $CoyoteJumpTimer.is_stopped():
		$JumpPressedTimer.stop()
		$CoyoteJumpTimer.stop()
		velocity.y = JUMP_VELOCITY
	if Input.is_action_just_released("jump"):
		if velocity.y < 0:
			velocity.y *= .5

	var dir = Input.get_axis("left", "right")
	velocity.x = dir * SPEED
	direction = dir
	move_and_slide()
