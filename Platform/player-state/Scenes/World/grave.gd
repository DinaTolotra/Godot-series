extends Sprite2D

enum DIR {LEFT = -1, RIGHT = 1}
@export var spawn_direction = DIR.RIGHT

var skull_scene = preload("res://Scenes/Character/skull.tscn")

func spawn() -> void:
	var skull : Mob = skull_scene.instantiate()
	var tree = get_tree()
	skull.global_position = global_position
	tree.root.add_child(skull)
	if spawn_direction == DIR.LEFT:
		skull._look_at_left()
	else:
		skull._look_at_right()
