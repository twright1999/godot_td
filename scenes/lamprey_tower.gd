extends Node2D

signal dart(pos, rot)
var balloons_in_range := []
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	balloons_in_range = $Range.get_overlapping_areas()
	if not balloons_in_range.is_empty():
		var highest_progress = 0
		var targeted_balloon = null
		for balloon in balloons_in_range:
			print(balloon.get_parent())
			var balloon_progress = balloon.get_parent().progress_ratio
			if balloon_progress > highest_progress:
				highest_progress = balloon_progress
				targeted_balloon = balloon
		look_at(targeted_balloon.global_transform.origin)

func _on_timer_timeout() -> void:
	dart.emit($DartOrigin.global_position, rotation)
