extends Node2D

# Load balloon scene
var blue_balloon_scene: PackedScene = load("res://scenes/blue_balloon.tscn")
var green_balloon_scene: PackedScene = load("res://scenes/green_balloon.tscn")

func _on_balloon_timer_timeout() -> void:
	var rng := RandomNumberGenerator.new()
	var random_number = rng.randf_range(-1.0, 1.0)
	
	if random_number > 0:
		$Path2D.add_child(blue_balloon_scene.instantiate())
	else:
		$Path2D.add_child(green_balloon_scene.instantiate())
