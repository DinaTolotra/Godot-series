extends StaticBody2D
class_name Construction

@export var size : Vector2i
@export var visual_model : PackedScene

func get_visual_model() -> Node2D:
	return visual_model.instantiate()
