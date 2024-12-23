extends Node2D

@onready var ground : TileMapLayer = $Ground
# false: there is no construction above
# true: there is a construction above
var construction_tile_data : Array[Array]
var tile_size : int = 0
var ground_width : int = 0
var ground_height : int = 0


func _get_construction_tile_data(pos: Vector2i) -> bool:
	var x = pos.x
	var y = pos.y
	if x >= ground_width or x < 0: return true
	if y >= ground_height or y < 0: return true
	return construction_tile_data[y][x]

func _set_construction_tile_data(pos: Vector2i, value: bool) -> void:
	var x = pos.x
	var y = pos.y
	if x >= ground_width or x < 0: return
	if y >= ground_height or y < 0: return
	construction_tile_data[y][x] = value

func can_construct_on(top_left: Vector2i, bottom_right: Vector2i) -> bool:
	var can_constrcut = true
	var TL_pos = top_left - top_left%tile_size
	var BR_pos = bottom_right - bottom_right%tile_size
	for tile_x in range(TL_pos.x, BR_pos.x, 16):
		for tile_y in range(TL_pos.y, BR_pos.y, 16):
			var tile_pos = to_local(Vector2i(tile_x, tile_y))
			var map_pos = ground.local_to_map(tile_pos)
			can_constrcut = can_constrcut and not _get_construction_tile_data(map_pos)
	return can_constrcut

func construct_on(top_left: Vector2i, bottom_right: Vector2i) -> void:
	var TL_pos = top_left - top_left%tile_size
	var BR_pos = bottom_right - bottom_right%tile_size
	for tile_x in range(TL_pos.x, BR_pos.x, 16):
		for tile_y in range(TL_pos.y, BR_pos.y, 16):
			var tile_pos = to_local(Vector2i(tile_x, tile_y))
			var map_pos = ground.local_to_map(tile_pos)
			_set_construction_tile_data(map_pos, true)

func _ready() -> void:
	var tile_set = ground.tile_set
	tile_size = tile_set.tile_size.x
	var ground_rect = ground.get_used_rect()
	ground_width = ground_rect.size.x
	ground_height = ground_rect.size.y
	construction_tile_data.resize(ground_height)
	for row in construction_tile_data:
		row.resize(ground_width)
		row.fill(false)
