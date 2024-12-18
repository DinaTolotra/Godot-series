extends CharacterBody2D

signal focus(body: CharacterBody2D)

@export var speed : float = 150
@onready var sprite = $ Sprite

var _target : Vector2 = Vector2.INF
var _can_be_selected : bool = false

func set_target(target: Vector2) -> void:
	_target = target

func _update_display() -> void:
	if velocity.x < 0:
		sprite.flip_h = true
	elif velocity.x > 0:
		sprite.flip_h = false
	if velocity.is_zero_approx():
		sprite.play("idle")
	else:
		sprite.play("move")

func _physics_process(_delta: float) -> void:
	if global_position.distance_squared_to(_target) < 4:
		_target = Vector2.INF
	if _target.is_finite():
		velocity = Steering.goto(global_position, _target, speed)
	else:
		velocity = Vector2.ZERO
	_update_display()
	move_and_slide()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("select") and _can_be_selected:
		focus.emit(self)


func _on_mouse_entered() -> void:
	_can_be_selected = true

func _on_mouse_exited() -> void:
	_can_be_selected = false
