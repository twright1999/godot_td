extends Area2D

var projectile_damage = 1
var speed = 1000
var damage_type = "normal"
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += Vector2(1, 0).rotated(rotation) * speed * delta

func _on_timer_timeout() -> void:
	queue_free()
