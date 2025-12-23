extends Area2D

var speed = 500
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += Vector2(1, 0).rotated(rotation) * speed * delta

func _on_timer_timeout() -> void:
	queue_free()
