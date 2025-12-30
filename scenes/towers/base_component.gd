extends Area2D

var building_obstructions: Array[Node2D] = []

func _on_area_entered(area: Area2D) -> void:
	building_obstructions.append(area.get_parent())
	
func _on_area_exited(area: Area2D) -> void:
	building_obstructions.erase(area.get_parent())

func is_building_colliding() -> bool:
	return len(building_obstructions) > 0
