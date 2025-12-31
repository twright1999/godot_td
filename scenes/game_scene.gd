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
	# Initiates build mode for tower_type binded to button in _ready()
	if build_mode:
		# If already in build mode, cancel previous build mode to avoid
		#	duplication/cloning of preview towers
		cancel_build_mode()
	build_type = tower_type
	build_mode = true
	# Begin previewing tower_type to build
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
	# If tower can be built, create tower at position and set built to true
	if build_valid:
		var new_tower = load("res://scenes/towers/lamprey_tower.tscn").instantiate()
		new_tower.position = build_location
		new_tower.built = true
		$World.get_node("Towers").add_child(new_tower)

func update_tower_preview():
	var mouse_position = get_global_mouse_position()
	var drag_tower = get_node("UI/TowerPreview/DragTower")
	
	# Checks if tower is colliding with pre-existing towers or designated
	#	path exclusion area
	if drag_tower.base and drag_tower.base.is_building_colliding():
		# Set tower preview to red shade and disallow building
		$UI.update_tower_preview(mouse_position, "ff5a76")
		build_valid = false
	else:
		# Set tower preview to green shade and allow building
		$UI.update_tower_preview(mouse_position, "3ff05f")
		build_valid = true
		build_location = mouse_position
		
func cancel_build_mode():
	build_mode = false
	build_valid = false
	# Remove tower preview
	get_node("UI/TowerPreview").free()
