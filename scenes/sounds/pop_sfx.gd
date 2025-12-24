extends AudioStreamPlayer

func _ready() -> void:
	pitch_scale = randf_range(0.7, 1.3)

func _on_finished() -> void:
	queue_free()
