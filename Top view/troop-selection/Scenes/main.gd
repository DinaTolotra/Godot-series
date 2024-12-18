extends Node2D

@onready var target = $Target

var warrior : CharacterBody2D


func _update_target_position() -> void:
	var mouse_pos = get_global_mouse_position()
	var tile_pos = (mouse_pos/64).floor()*64
	target.global_position = tile_pos
	warrior.set_target(target.global_position+Vector2(32, 32))

func set_focus(body: CharacterBody2D) -> void:
	warrior = body

func _input(event: InputEvent) -> void:
	if warrior == null: return
	if event.is_action_pressed("set_target"):
		_update_target_position()
		target.show()
