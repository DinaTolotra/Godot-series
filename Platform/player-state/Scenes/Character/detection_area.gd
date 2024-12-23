extends Area2D

var body_list : Dictionary

func add_to_list(body: Node2D) -> void:
	var pos = global_position
	var body_pos = body.global_position
	body_list[body] = pos.distance_squared_to(body_pos)

func remove_to_list(body: Node2D) -> void:
	body_list.erase(body)

func get_nearest_mob() -> Mob:
	var nearest_body = null
	for body in body_list:
		if body is not Mob:
			break
		if not nearest_body:
			nearest_body = body
		else:
			var body_dist = body_list[body]
			var nearest_dist = body_list[nearest_body]
			if body_dist < nearest_dist:
				nearest_body = body
	return nearest_body
