extends PathFollow2D

var balloon_type
var health
var speed
var ready_progress = 0

var balloon_scene: PackedScene = load("res://scenes/balloons/balloon.tscn")

func _init() -> void:
	self.balloon_type = "red_balloon"
	self.health = 1
	self.speed = 0
	
func _ready() -> void:
	progress_ratio = ready_progress

func _process(delta: float) -> void:
	move_balloon(delta)

func _on_area_2d_area_entered(area: Area2D) -> void:
	area.queue_free()
	pop_balloon()

##
## Balloon moving logic
##
func move_balloon(delta: float) -> void:
	# Move balloon along path according to SPEED
	progress_ratio += speed * delta

	# Handle logic if balloon reaches end of path
	if progress_ratio >= 1.0:
		balloon_reaches_end()

func balloon_reaches_end() -> void:
	# Kills current balloon and prints debug message
	print(balloon_type, " reached the exit")
	queue_free()
	
##
## Balloon popping logic
##
func pop_balloon() -> void:
	# Kills current balloon and prints debug message
	var spawn_list = BalloonData.balloon_data[balloon_type]["contains"].duplicate()
	print(balloon_type, " was popped, spawning ", spawn_list)
	
	if spawn_list.is_empty():
		# If balloon contains no other balloons (red), kill balloon
		queue_free()
	elif len(spawn_list) == 1:
		# If balloon contains 1 other balloon, become that balloon
		var new_balloon = spawn_list[0]
		update_balloon_type(new_balloon)
	else:
		# If balloon contains multiple balloons, spawn balloons
		update_balloon_type(spawn_list.pop_front())
		for child_balloon in spawn_list:
			spawn_child_balloon(child_balloon)
			queue_free()

func update_balloon_type(new_balloon_type: String) -> void:
	self.balloon_type = new_balloon_type
	self.health = BalloonData.balloon_data[new_balloon_type]["health"]
	self.speed = BalloonData.balloon_data[new_balloon_type]["speed"]
	$Sprite2D.texture = load(BalloonData.balloon_data[new_balloon_type]["sprite_path"])

func spawn_child_balloon(new_balloon: String) -> void:
	var rng := RandomNumberGenerator.new()
	var child_balloon = balloon_scene.instantiate()
	child_balloon.update_balloon_type(new_balloon)
	child_balloon.ready_progress = progress_ratio + rng.randf_range(-0.005, 0.005)
	get_parent().call_deferred("add_child", child_balloon)
	
