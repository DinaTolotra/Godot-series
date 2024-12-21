extends Node2D

@onready var modulator = $Modulator

func screen_effect(color: Color, duration: float) -> void:
	var tween = create_tween()
	tween.tween_property(modulator, "color", color, duration)
	tween.tween_property(modulator, "color", Color.WHITE, duration)


func heart_changed(from: int, to: int) -> void:
	if from < to: screen_effect(Color.DARK_GREEN, 0.125)
	elif from > to: screen_effect(Color.FIREBRICK, 0.125)
