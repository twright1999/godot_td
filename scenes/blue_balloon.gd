extends PathFollow2D

@export var speed := 0.1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	progress_ratio += speed * delta
	
	if progress_ratio >= 0.2:
		queue_free()
	
