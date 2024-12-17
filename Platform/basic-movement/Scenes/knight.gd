extends CharacterBody2D

@onready var sprite = $Sprite

@export var speed = 100.0
@export var jump_velocity = -200.0


func apply_gravity(delta: float) -> void:
	velocity += get_gravity() * delta

func jump() -> void:
	velocity.y = jump_velocity

func horizental_movement() -> void:
	var direction := Input.get_axis("move_left", "move_right")
	velocity.x = move_toward(velocity.x, direction*speed, speed/2)

func update_display() -> void:
	if velocity.x != 0 and is_on_floor():
		sprite.play("move")
	else: sprite.play("idle")
	if velocity.x < 0: sprite.flip_h = true
	elif velocity.x > 0: sprite.flip_h = false

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		apply_gravity(delta)
	if Input.is_action_just_pressed("jump") and is_on_floor():
		jump()
	if is_on_floor():
		horizental_movement()
	update_display()
	move_and_slide()
