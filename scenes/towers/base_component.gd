extends Area2D

var building_obstructions: Array[Node2D] = []
@export var targeting_range : CollisionShape2D

var built := false :
	set(value):
		# If new value is different, call redraw() to update targeting range visibility
		if value != built:
			built = value
			queue_redraw()

func _on_area_entered(area: Area2D) -> void:
	building_obstructions.append(area.get_parent())
	
func _on_area_exited(area: Area2D) -> void:
	building_obstructions.erase(area.get_parent())

func is_building_colliding() -> bool:
	return len(building_obstructions) > 0

func _draw():
	if not built:
		# Draw a circle the same size as the targeting range
		draw_circle(Vector2.ZERO, targeting_range.shape.radius, Color("95959580"), true)
