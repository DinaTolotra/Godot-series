extends Node

const DEFAULT_SPEED := 100.0

func goto(
	position: Vector2,
	target: Vector2,
	speed: = DEFAULT_SPEED
) -> Vector2:
	var dir = target - position
	dir = dir.normalized()
	return dir * speed
