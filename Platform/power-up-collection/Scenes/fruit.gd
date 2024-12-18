extends RigidBody2D

@onready var pick_are = $PickArea
@onready var shape = $Shape


func _process(delta: float) -> void:
	pass


func pick(body: Node2D) -> void:
	if body is CharacterBody2D:
		var tween = create_tween()
		tween.tween_property(self, "scale", Vector2(2, 2), 0.125)
		tween.tween_property(self, "scale", Vector2(0, 0), 0.25)
		await tween.finished
		queue_free()
