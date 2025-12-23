extends PathFollow2D

@export var SPEED := 0.05
@export var LIFETIME := 1
# When, on a scale of 0-1, entity will be killed

var green_balloon_scene: PackedScene = load("res://scenes/green_balloon.tscn")
var new_progress

func _process(delta: float) -> void:
	new_progress = progress_ratio + SPEED * delta
	# Calculates theoretical new progress
	
	if new_progress >= LIFETIME:
		# If new progress is larger than defined LIFETIME, kill entity
		print("KILLED ", name)
		queue_free()
	else:
		progress_ratio = new_progress

func _on_area_2d_area_entered(area: Area2D) -> void:
	var new_balloon = green_balloon_scene.instantiate()
	# Instantiates new balloon to spawn after taking damage
	
	var balloon_parent = get_parent()
	# Gets parent of current balloon for new balloon to spawn under
	
	balloon_parent.call_deferred("add_child", new_balloon)
	new_balloon.set_deferred("progress_ratio", progress_ratio)
	# Defers adding new balloon and setting of new balloons progress
	# Necessary to avoid collisions changing while inside area_entered
	
	area.queue_free()
	queue_free()
	# Kills projectile and current balloon
