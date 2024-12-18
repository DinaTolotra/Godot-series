extends StaticBody2D

@onready var ray = $Ray
var fruit = preload("res://Scenes/fruit.tscn").instantiate()

func _physics_process(delta: float) -> void:
	if ray.is_colliding():
		fruit.global_position = global_position
		get_tree().root.add_child(fruit)
		queue_free()
