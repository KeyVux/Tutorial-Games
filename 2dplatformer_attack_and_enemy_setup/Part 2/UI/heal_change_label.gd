extends Label

@export var float_speed: Vector2 = Vector2(0, -50)


func _process(delta: float) -> void:
	position += float_speed * delta


func _on_timer_timeout() -> void:
	queue_free()
