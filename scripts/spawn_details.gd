extends RefCounted
class_name SpawnDetails

var properties : Array[Dictionary] = []

func _init(properties_size : int) -> void:
	properties.resize(properties_size)
