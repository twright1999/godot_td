extends Node2D

# Load balloon scene
var balloon_scene: PackedScene = load("res://scenes/balloons/balloon.tscn")
var lamprey_dart_scene: PackedScene = load("res://scenes/projectiles/lamprey_dart.tscn")

func _on_balloon_timer_timeout() -> void:
	spawn_random_balloon()

func _on_lamprey_tower_dart(pos, rot) -> void:
	var lamprey_dart = lamprey_dart_scene.instantiate()
	lamprey_dart.position = pos
	lamprey_dart.rotation = rot
	$Darts.add_child(lamprey_dart)

##
## Balloon spawning
##
func spawn_random_balloon() -> void:
	# Selects and spawns a random balloon
	var rng := RandomNumberGenerator.new()
	var balloon = balloon_scene.instantiate()
	var balloon_array = ["red_balloon", "blue_balloon", "green_balloon"]
	balloon.update_balloon_type(balloon_array[rng.randi_range(0, len(balloon_array)-1)])
	
	# Adds balloon to path parent
	$Path2D.add_child(balloon)
