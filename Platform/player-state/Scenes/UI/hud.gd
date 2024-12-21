extends CanvasLayer

@onready var heart_container = $MainContainer/HeartContainer

var heart_scene = preload("res://Scenes/UI/heart.tscn")
var heart_list : Array

func _add_heart(index: int) -> void:
	var heart = heart_scene.instantiate()
	heart.name = "Heart" + String.num(index)
	heart_container.add_child(heart)
	heart_list.append(heart)

func _remove_heart() -> void:
	if heart_list.is_empty(): return
	var heart = heart_list.back()
	heart_list.pop_back()
	heart.queue_free()

func set_heart_count(_from: int, to: int) -> void:
	var current_count = heart_list.size()
	for i in range(to, current_count):
		_remove_heart()
	for i in range(current_count, to):
		_add_heart(i)
