extends PathFollow2D

@export var SPEED := 0.05

var green_balloon_scene: PackedScene = load("res://scenes/green_balloon.tscn")

func _process(delta: float) -> void:
	move_balloon(delta)

func _on_area_2d_area_entered(area: Area2D) -> void:
	pop_balloon()
	area.queue_free()

##
## Balloon moving logic
##
func move_balloon(delta: float) -> void:
	# Move balloon along path according to SPEED
	progress_ratio += SPEED * delta

	# Handle logic if balloon reaches end of path
	if progress_ratio >= 1.0:
		balloon_reaches_end()

func balloon_reaches_end() -> void:
	# Kills current balloon and prints debug message
	print(name, " reached the exit")
	queue_free()
	
##
## Balloon popping logic
##
func pop_balloon() -> void:
	# Instantiates new balloon to spawn after taking damage
	var new_balloon = green_balloon_scene.instantiate()
	
	# Gets parent of current balloon for new balloon to spawn under
	var balloon_parent = get_parent()
	
	# Defers adding new balloon and setting of new balloons progress
	# Necessary to avoid collisions changing while inside area_entered
	balloon_parent.call_deferred("add_child", new_balloon)
	new_balloon.set_deferred("progress_ratio", progress_ratio)

	# Kills current balloon and prints debug message
	print(name, " was popped")
	queue_free()
