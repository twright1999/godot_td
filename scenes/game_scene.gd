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
	if build_mode:
		cancel_build_mode()
	build_type = tower_type
	build_mode = true
	$UI.set_tower_preview(build_type, get_global_mouse_position())
	
func _process(_delta: float) -> void:
	if build_mode:
		update_tower_preview()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_released("ui_cancel") and build_mode == true:
		cancel_build_mode()
	if event.is_action_released("ui_accept") and build_mode == true:
		verify_and_build()
		cancel_build_mode()

func verify_and_build():
	if build_valid:
		var new_tower = load("res://scenes/towers/lamprey_tower.tscn").instantiate()
		new_tower.position = build_location
		new_tower.built = true
		$World.get_node("Towers").add_child(new_tower)

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
	build_mode = false
	build_valid = false
	get_node("UI/TowerPreview").free()
