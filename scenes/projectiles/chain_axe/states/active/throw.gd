extends State # extend state machine to handle child states


const throw_speed : int = 300

func _enter() -> void:
	character.velocity = character.direction * throw_speed
	super()

var gravity : int = ProjectSettings.get_setting("physics/2d/default_gravity") * .5

signal hit()
func _physics_do(delta : float) -> void:
	character.velocity.y += gravity * delta
	character.direction = character.velocity.normalized()
	if character.move_and_collide(character.velocity * delta) != null:
		hit.emit()
	super(delta)

func _try_leave() -> void: #super._do() calls this every frame
	pass

#region Default State fucntions

func _can_enter() -> bool:
	return true

func _can_exit() -> bool:
	return true

func _exit() -> void:
	super()

func _do(_delta : float) -> void:
	pass
#endregion
