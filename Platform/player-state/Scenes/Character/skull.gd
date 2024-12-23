extends Mob

@onready var LOS = $LOS
@onready var detection_area = $DetectionArea


func take_damage() -> void:
	super.take_damage()
	set_freeze(true)
	sprite.play("damage")
	await sprite.animation_finished
	set_freeze(false)

func _look_at_left() -> void:
	super._look_at_left()
	LOS.target_position.x = -abs(LOS.target_position.x)

func _look_at_right() -> void:
	super._look_at_right()
	LOS.target_position.x = abs(LOS.target_position.x)


func detect_mob() -> void:
	var mob : Mob = detection_area.get_nearest_mob()
	if mob == null: return
	var mob_pos = mob.global_position
	var pos = global_position
	var mob_dir = pos.direction_to(mob_pos)
	if mob_dir.x > 0: _look_at_right()
	elif mob_dir.x < 0: _look_at_left()

func check_collision() -> void:
	if LOS.is_colliding() and not freeze:
		if LOS.get_collider() is CharacterBody2D:
			_attack() 
		else:
			if dir > 0: _look_at_left()
			elif dir < 0: _look_at_right()

func update_display() -> void:
	if not freeze:
		sprite.play("move")


func _ready() -> void:
	super._ready()
	if dir < 0: _look_at_left()
	elif dir > 0: _look_at_right()

func _physics_process(delta: float) -> void:
	detect_mob()
	check_collision()
	apply_gravity(delta)
	change_velocity()
	move_and_slide()
	update_display()
	if heart <= 0: die()
