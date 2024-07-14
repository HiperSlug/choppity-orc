extends Marker2D
class_name Spawner

signal spawned(spawn)
@export_category("stuff")
@export var spawn_scene : PackedScene
@export var max_spawns : int = 1

@export_category("other stuff")
var spawns_alive : Array

func _ready() -> void:
	get_tree().get_first_node_in_group("level").connect_spawner(self) #idk a cleaner way to do this

func spawn(spawn_details : SpawnDetails):
	if spawns_alive.size() < max_spawns:
		var a := spawn_scene.instantiate()
		
		a.global_position = global_position
		
		for property in spawn_details.properties:
			print()
			if a.get(property["name"]) != null:
				a.set(property["name"],property["value"])
		
		a.connect("destroyed",on_spawn_destroyed)
		spawns_alive.append(a)
		spawned.emit(a)
		return a

func on_spawn_destroyed(node) -> void:
	spawns_alive.erase(node)

func destroy_all_spawn() -> void:
	for thingy in spawns_alive:
		thingy.destroy()
