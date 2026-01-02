extends CanvasLayer

func set_tower_preview(tower_type, mouse_position):
	print("building ", tower_type)
	
	# Instantiate the tower to be previewed
	var drag_tower = tower_type.instantiate()
	drag_tower.set_name("DragTower")
	drag_tower.modulate = Color("ff5a76")
	
	# Create a control parent to contain the preview tower
	var control = Control.new()
	control.add_child(drag_tower, true)
	control.set_position(mouse_position)
	control.set_name("TowerPreview")
	add_child(control, true)
	
	# Move control to the lowest priority so it is rendered under UI
	move_child(control, 0)

func update_tower_preview(new_position, color):
	$TowerPreview.position = new_position
	
	if $TowerPreview/DragTower/GrabPoint:
		$TowerPreview.position -= $TowerPreview/DragTower/GrabPoint.position
		
	# Change color to new specified color if it has changed
	if get_node("TowerPreview/DragTower").modulate != Color(color):
		get_node("TowerPreview/DragTower").modulate = Color(color)

func _on_set_speedup_fast() -> void:
	Engine.set_time_scale(2.0)
	Engine.physics_ticks_per_second = 120

func _on_set_speedup_normal() -> void:
	Engine.set_time_scale(1.0)
	Engine.physics_ticks_per_second = 60
