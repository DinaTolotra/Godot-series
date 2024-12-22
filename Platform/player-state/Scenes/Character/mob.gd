extends CharacterBody2D
class_name  Mob

signal heart_count_changed(from: int, to: int)

@export var speed = 25.0
@export var jump = -300.0

@onready var sprite = $Sprite
@onready var shape = $Shape
@onready var left_hit = $LeftHitBox
@onready var right_hit = $RightHitBox

var freeze = false
var heart = 4
var dir = 1


func set_freeze(enabled: bool) -> void:
	freeze = enabled
	if freeze: velocity.x = 0

func take_damage() -> void:
	heart_count_changed.emit(heart, heart-1)
	heart -= 1

func heal() -> void:
	heart_count_changed.emit(heart, heart+1)
	heart += 1

func die() -> void:
	sprite.play("die")
	shape.disabled = true
	left_hit.disable()
	right_hit.disable()
	set_physics_process(false)
	await sprite.animation_finished
	var tween = create_tween()
	tween.tween_property(self, "modulate", Color.TRANSPARENT, 0.25)
	await tween.finished
	queue_free()

func _attack() -> void:
	set_freeze(true)
	sprite.play("attack")
	left_hit.damage()
	right_hit.damage()
	await sprite.animation_finished
	set_freeze(false)


func _look_at_right() -> void:
	right_hit.enable()
	left_hit.disable()
	sprite.flip_h = false

func _look_at_left() -> void:
	right_hit.disable()
	left_hit.enable()
	sprite.flip_h = true

func _move() -> void:
	velocity.x = dir * speed

func _jump() -> void:
	velocity.y = jump
	velocity.x = dir * speed * 2


func apply_gravity(delta: float) -> void:
	velocity += get_gravity() * delta

func change_velocity() -> void:
	if not freeze:
		velocity.x = dir*speed
