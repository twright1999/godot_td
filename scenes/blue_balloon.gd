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
	
	get_parent().add_child(new_balloon)
	new_balloon.progress_ratio = progress_ratio
	print(new_balloon.progress_ratio)
	
	area.queue_free()
	queue_free()
