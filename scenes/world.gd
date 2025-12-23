extends Node2D

# Load balloon scene
var blue_balloon_scene: PackedScene = load("res://scenes/blue_balloon.tscn")

func _on_balloon_timer_timeout() -> void:
	var blue_balloon = blue_balloon_scene.instantiate()
	
	$Path2D.add_child(blue_balloon)
