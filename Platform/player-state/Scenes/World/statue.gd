extends Area2D

var body_list : Dictionary

func create_timer() -> Timer:
	var timer = Timer.new()
	timer.autostart = true
	timer.wait_time = 1
	add_child(timer)
	return timer

func heal(body: Node2D) -> void:
	if body is Mob: body.heal()

func _on_body_entered(body: Node2D) -> void:
	var timer = create_timer()
	body_list[body] = timer
	timer.timeout.connect(heal.bind(body))


func _on_body_exited(body: Node2D) -> void:
	var timer = body_list[body]
	timer.queue_free()
	body_list.erase(body)
