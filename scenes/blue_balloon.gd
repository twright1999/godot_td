extends PathFollow2D

@export var SPEED := 0.05
@export var LIFETIME := 1
# When, on a scale of 0-1, entity will be killed

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
