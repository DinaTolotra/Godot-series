extends Area2D

@onready var shape = $Shape
@onready var hit_timer = $HitTimer

@export var can_damage = false
@export var hit_time = 0.5

var body_list : Dictionary
var wait_before_damage = true

func disable() -> void:
	can_damage = false
	shape.disabled = true

func enable() -> void:
	can_damage = true
	shape.disabled = false

func add_to_list(body: Node2D) -> void:
	body_list[body] = ""

func remove_to_list(body: Node2D) -> void:
	body_list.erase(body)

func damage() -> void:
	if not can_damage: return
	if wait_before_damage:
		hit_timer.start()
		await hit_timer.timeout
	# check if the mob still want to damage
	if not can_damage: return
	for body in body_list:
		if body.has_method("take_damage"):
			body.take_damage()

func _ready() -> void:
	wait_before_damage = hit_time != 0
	if wait_before_damage:
		hit_timer.wait_time = hit_time
	if can_damage: enable()
	else: disable()
