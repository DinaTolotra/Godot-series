extends Mob

@onready var LOS = $LOS
@onready var downward_ray = $DownwardRay


func take_damage() -> void:
	super.take_damage()
	set_freeze(true)
	sprite.play("damage")
	await sprite.animation_finished
	set_freeze(false)

func _look_at_left() -> void:
	super._look_at_left()
	downward_ray.position.x = -abs(downward_ray.position.x)
	LOS.target_position.x = -abs(LOS.target_position.x)

func _look_at_right() -> void:
	super._look_at_right()
	downward_ray.position.x = abs(downward_ray.position.x)
	LOS.target_position.x = abs(LOS.target_position.x)


func check_collision() -> void:
	if not downward_ray.is_colliding():
		dir *= -1
	if LOS.is_colliding() and not freeze:
		if LOS.get_collider() is CharacterBody2D:
			_attack() 

func update_display() -> void:
	if not freeze:
		sprite.play("move")
	if velocity.x > 0:
		_look_at_right()
	elif velocity.x < 0:
		_look_at_left()


func _physics_process(delta: float) -> void:
	check_collision()
	apply_gravity(delta)
	change_velocity()
	move_and_slide()
	update_display()
	if heart <= 0: die()
