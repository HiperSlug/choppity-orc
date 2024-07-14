extends State # extend state machine to handle child states


func _can_enter() -> bool:
	return true

func _can_exit() -> bool:
	return true

func _enter() -> void:
	super()

func _exit() -> void:
	super()

func _do(delta : float) -> void:
	super(delta)

func _physics_do(delta : float) -> void:
	super(delta)

func _try_leave() -> void: #super._do() calls this every frame
	pass
