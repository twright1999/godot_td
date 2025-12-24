extends Node2D

signal dart(pos, rot)
var balloons_in_range := []

var shrink_speed = 0.7
var grow_speed = 2

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	balloons_in_range = $Range.get_overlapping_areas()
	if not balloons_in_range.is_empty():
		show_lamprey(delta)
		
		var highest_progress = 0
		var targeted_balloon = null
		for balloon in balloons_in_range:
			var balloon_progress = balloon.get_parent().progress_ratio
			if balloon_progress > highest_progress:
				highest_progress = balloon_progress
				targeted_balloon = balloon
		$SpriteLamprey.look_at(targeted_balloon.global_transform.origin)
	elif $SpriteLamprey.visible:
		hide_lamprey(delta)

func _on_timer_timeout() -> void:
	if not balloons_in_range.is_empty():
		dart.emit($SpriteLamprey/DartOrigin.global_position, $SpriteLamprey.rotation)
		
func hide_lamprey(delta) -> void:
	if $SpriteLamprey.scale >= Vector2(0.0, 0.0) and $SpriteLamprey.visible:
		$SpriteLamprey.scale -= Vector2(shrink_speed, shrink_speed) * delta
	else:
		$SpriteLamprey.hide()

func show_lamprey(delta) -> void:
	if not $SpriteLamprey.visible:
		$SpriteLamprey.show()
	if $SpriteLamprey.scale <= Vector2(0.5, 0.5):
		$SpriteLamprey.scale += Vector2(grow_speed, grow_speed) * delta
