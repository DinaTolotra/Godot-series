extends Mob

@onready var ray = $Ray

func take_damage() -> void:
	super.take_damage()
	set_freeze(true)
	sprite.play("damage")
	await sprite.animation_finished
	set_freeze(false)

func get_user_control() -> void:
	if freeze or not is_on_floor(): return
	dir = Input.get_axis("move_left", "move_right")
	if dir < 0: _look_at_left()
	elif dir > 0: _look_at_right()
	if Input.is_action_just_pressed("jump"): _jump()
	_move()
	if Input.is_action_just_pressed("attack"):  _attack()

func update_display() -> void:
	if is_on_floor() and not freeze:
		if velocity.x != 0:
			sprite.play("move")
		else:
			sprite.play("idle")
	if velocity.y < 0 and not freeze:
		sprite.play("jump")
	elif velocity.y > 0 and not freeze:
		sprite.play("fall")
	if not ray.is_colliding():
		sprite.animation = "fall"
		sprite.frame = 0
		sprite.pause()
		set_freeze(false)


func _ready() -> void:
	super._ready()
	heart_count_changed.emit(heart, heart)

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		apply_gravity(delta)
	get_user_control()
	move_and_slide()
	update_display()
	if heart <= 0: die()
