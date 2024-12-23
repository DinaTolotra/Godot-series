extends CanvasLayer

signal construct(construction: PackedScene)

var house = preload("res://Scenes/Construction/house.tscn")
var tower = preload("res://Scenes/Construction/tower.tscn")

func set_focus_on_house() -> void:
	construct.emit(house)

func set_focus_on_tower() -> void:
	construct.emit(tower)

func unfocus() -> void:
	construct.emit(null)


func _on_house_button_toggled(toggled_on: bool) -> void:
	if toggled_on: set_focus_on_house()
	else: unfocus()

func _on_tower_button_toggled(toggled_on: bool) -> void:
	if toggled_on: set_focus_on_tower()
	else: unfocus()
