extends Area2D

var targets_in_range: Array[Node2D] = []
var show_range := false :
	set(value):
		if value != show_range:
			show_range = value
			queue_redraw()

func _on_area_entered(area: Area2D) -> void:
	targets_in_range.append(area.get_parent())
	
func _on_area_exited(area: Area2D) -> void:
	targets_in_range.erase(area.get_parent())
	
func get_first_target() -> Node2D:
	var highest_progress = 0
	var target_balloon = null
	for balloon in targets_in_range:
		if balloon.progress_ratio > highest_progress:
			highest_progress = balloon.progress_ratio
			target_balloon = balloon
	
	return target_balloon

func _draw():
	if show_range:
		draw_circle(Vector2.ZERO, $CollisionShape2D.shape.radius, Color("95959580"), true)
