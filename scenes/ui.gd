extends CanvasLayer

func _ready():
	get_node("HUD/HUDMargin/GameSpeedControl/PlayPause").pressed.connect(on_play_paused_pressed)
	get_node("HUD/HUDMargin/GameSpeedControl/SpeedUp").pressed.connect(on_speedup_pressed)

func on_play_paused_pressed():
	if get_tree().is_paused():
		get_tree().paused = false
	else:
		get_tree().paused = true
	
func on_speedup_pressed():
	if Engine.get_time_scale() == 1.0:
		Engine.set_time_scale(2.0)
		Engine.physics_ticks_per_second = 120
	else:
		Engine.set_time_scale(1.0)
		Engine.physics_ticks_per_second = 60

func set_tower_preview(tower_type, mouse_position):
	# TODO use tower_type to load the correct tower scene
	#	(hardcoded to lamprey tower below)
	print("building ", tower_type)
	
	# Instantiate the tower to be previewed
	var drag_tower = load("res://scenes/towers/lamprey_tower.tscn").instantiate()
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
	# Change color to new specified color if it has changed
	if get_node("TowerPreview/DragTower").modulate != Color(color):
		get_node("TowerPreview/DragTower").modulate = Color(color)
