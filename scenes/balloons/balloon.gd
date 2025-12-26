extends PathFollow2D

var balloon_type
var health
var speed
var ready_progress
var rng := RandomNumberGenerator.new()
var dispersion = 0.002

var balloon_scene: PackedScene = load("res://scenes/balloons/balloon.tscn")
var pop_scene: PackedScene = load("res://scenes/sounds/pop_sfx.tscn")

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
	# Spawns all balloons contained inside popped balloon
	# Popped balloons are spawned randomly offset to parent balloon to stop bunching
	var spawn_list = BalloonData.balloon_data[balloon_type]["contains"]
	var dispersion_list = get_evenly_distributed_range(len(spawn_list))
	for i in len(spawn_list):
		spawn_balloon(spawn_list[i], get_parent(), dispersion_list[i] * dispersion + progress_ratio)
	
	# Plays pop sound effect
	get_parent().add_child(pop_scene.instantiate())
	
	# Kills balloon
	queue_free()
	
	# Uncomment for pop debug
	print(balloon_type, " was popped, spawning ", spawn_list)

func get_evenly_distributed_range(n : float) -> Array:
	# Given n, returns an array of n items distributed evenly between -1 and 1
	# E.g.
	# n = 0 returns []
	# n = 1 returns [0]
	# n = 2 returns [-1, 1]
	# n = 3 returns [-1, 0, -1]
	# Used for distributing spawned balloons uniformly along path
	if n <= 0:
		return []
	elif n == 1:
		return [0]
	else:
		var distributed_range = []
		for i in range(n):
			distributed_range.append(-1 + i * (2/(n-1)))
		return distributed_range
##
## Balloon spawning logic
##
func spawn_balloon(new_balloon_type: String, parent_path: Path2D, new_progress_ratio: float):
	var new_balloon = balloon_scene.instantiate()
	
	# Sets new balloon attributes before parenting to path
	new_balloon.balloon_type = new_balloon_type
	new_balloon.health = BalloonData.balloon_data[new_balloon_type]["health"]
	new_balloon.speed = BalloonData.balloon_data[new_balloon_type]["speed"]
	new_balloon.get_node("Sprite2D").texture = load(BalloonData.balloon_data[new_balloon_type]["sprite_path"])
	
	# Progress cannot be immediately set as balloon is not yet child to path
	# 	so set intermediate "ready" progress before adding child
	new_balloon.ready_progress = new_progress_ratio
	
	# Set new balloon as child of Path2D, which calls _ready function and sets
	# 	progress to ready_progress set above
	parent_path.call_deferred("add_child", new_balloon)
	
func _ready() -> void:
	progress_ratio = ready_progress
	
func _init() -> void:
	ready_progress = 0
