extends Projectile



@onready var player : Player = get_tree().get_first_node_in_group("player")
var direction : Vector2:
	set(value):
		direction = value
		rotation = direction.angle()

func destroy() -> void:
	destroyed.emit(self)
	queue_free()


@onready var line_2d: Line2D = $Line/Line2D
func _ready() -> void:
	line_2d.add_point(player.global_position)
	line_2d.add_point(global_position)
func _physics_process(_delta: float) -> void:
	line_2d.points[0] = player.global_position
	line_2d.points[1] = global_position
