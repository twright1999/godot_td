extends Node2D

# Load balloon scene
var blue_balloon_scene: PackedScene = load("res://scenes/balloons/blue_balloon.tscn")
var green_balloon_scene: PackedScene = load("res://scenes/balloons/green_balloon.tscn")
var lamprey_dart_scene: PackedScene = load("res://scenes/projectiles/lamprey_dart.tscn")

func _on_balloon_timer_timeout() -> void:
	spawn_balloon()

func _on_lamprey_tower_dart(pos, rot) -> void:
	print("dart shooted", pos, rot)
	var lamprey_dart = lamprey_dart_scene.instantiate()
	lamprey_dart.position = pos
	lamprey_dart.rotation = rot
	$Darts.add_child(lamprey_dart)

##
## Balloon spawning
##
func spawn_balloon() -> void:
	var rng := RandomNumberGenerator.new()
	var random_number = rng.randf_range(-1.0, 1.0)
	
	if random_number > 0:
		var blue_balloon = blue_balloon_scene.instantiate()
		blue_balloon.update_balloon_type("blue_balloon")
		$Path2D.add_child(blue_balloon)
	else:
		var green_balloon = green_balloon_scene.instantiate()
		green_balloon.update_balloon_type("green_balloon")
		$Path2D.add_child(green_balloon)
