extends Node2D

var map_node

var build_mode = false
var build_valid = false
var build_location
var build_type

func _ready() -> void:
	# For each build button, binds the button to the initiate_build_mode function
	for i in get_tree().get_nodes_in_group("BuildButtons"):
		# Adds the tower name as a parameter passed to the binded function
		i.pressed.connect(initiate_build_mode.bind(i.get_name()))

func initiate_build_mode(tower_type):
	build_type = tower_type
	build_mode = true
	$UI.set_tower_preview(build_type, get_global_mouse_position())
	
func _process(_delta: float) -> void:
	if build_mode:
		update_tower_preview()

func update_tower_preview():
	var mouse_position = get_global_mouse_position()
	
	if not get_node("UI/TowerPreview/DragTower").build_colliding:
		$UI.update_tower_preview(mouse_position, "3ff05f")
		build_valid = true
		build_location = mouse_position
	else:
		$UI.update_tower_preview(mouse_position, "ff5a76")
		build_valid = false
	
func cancel_build_mode():
	pass
