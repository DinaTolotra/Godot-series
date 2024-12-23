extends Node2D

@onready var hud = $HUD
@onready var world = $World

var current_construction : PackedScene
var construction : Construction
var model : Sprite2D

func focus_on_construction(_construction: PackedScene) -> void:
	current_construction = _construction
	_update_object()


func _update_object() -> void:
	if current_construction != null:
		construction = current_construction.instantiate()
		model = construction.get_visual_model()
		_update_model_display()
		add_child(model)

func _update_model_display() -> void:
	var pos = get_global_mouse_position()
	var tile_pos = Vector2i(pos) - Vector2i(pos) % world.tile_size
	model.global_position = tile_pos
	if world.can_construct_on(tile_pos, tile_pos+construction.size):
		model.self_modulate = Color.GREEN
	else:
		model.self_modulate = Color.RED

func _get_tile_pos() -> Vector2i:
	var pos = get_global_mouse_position()
	return Vector2i(pos) - Vector2i(pos) % world.tile_size


func construct() -> void:
	var tile_pos = _get_tile_pos()
	if world.can_construct_on(tile_pos, tile_pos+construction.size):
		construction.global_position = model.global_position
		hud.unfocus()
		model.queue_free()
		add_child(construction)
		world.construct_on(tile_pos, tile_pos+construction.size)
		current_construction = null

func _input(event: InputEvent) -> void:
	if current_construction == null: return
	_update_model_display()
	if event.is_action_pressed("construct"):
		construct()
