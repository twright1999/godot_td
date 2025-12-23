extends PathFollow2D

@export var SPEED := 0.05

var green_balloon_scene: PackedScene = load("res://scenes/green_balloon.tscn")

func _process(delta: float) -> void:
	progress_ratio += SPEED * delta

	if progress_ratio >= 1.0:
		print(name, " reached the exit")
		queue_free()

func _on_area_2d_area_entered(area: Area2D) -> void:
	var new_balloon = green_balloon_scene.instantiate()
	# Instantiates new balloon to spawn after taking damage
	
	var balloon_parent = get_parent()
	# Gets parent of current balloon for new balloon to spawn under
	
	balloon_parent.call_deferred("add_child", new_balloon)
	new_balloon.set_deferred("progress_ratio", progress_ratio)
	# Defers adding new balloon and setting of new balloons progress
	# Necessary to avoid collisions changing while inside area_entered
	
	print(name, " was popped")
	area.queue_free()
	queue_free()
	# Kills projectile and current balloon
