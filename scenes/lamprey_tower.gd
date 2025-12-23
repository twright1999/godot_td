extends Node2D

signal dart(pos, rot)
var last_entered
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if last_entered:
		look_at(last_entered.global_transform.origin)

func _on_range_area_entered(area: Area2D) -> void:
	last_entered = area
	print(area)

func _on_timer_timeout() -> void:
	dart.emit($DartOrigin.global_position, rotation)
