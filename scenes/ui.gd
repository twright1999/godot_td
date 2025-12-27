extends CanvasLayer

func set_tower_preview(tower_type, mouse_position):
	var drag_tower = load("res://scenes/towers/lamprey_tower.tscn").instantiate()
	drag_tower.set_name("DragTower")
	drag_tower.modulate = Color("ff5a76")
	
	var control = Control.new()
	control.add_child(drag_tower, true)
	control.set_position(mouse_position)
	control.set_name("TowerPreview")
	add_child(control, true)
	move_child(control, 0)

func update_tower_preview(new_position, color):
	$TowerPreview.position = new_position
	if get_node("TowerPreview/DragTower").modulate != Color(color):
		get_node("TowerPreview/DragTower").modulate = Color(color)
