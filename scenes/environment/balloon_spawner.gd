extends Node2D

var balloon_scene: PackedScene = load("res://scenes/balloons/balloon.tscn")
var balloon = balloon_scene.instantiate()
var rng := RandomNumberGenerator.new()

##
## Balloon spawning
##
func _on_balloon_timer_timeout() -> void:
	spawn_random_balloon()

func spawn_random_balloon() -> void:
	# Selects and spawns a random balloon
	var balloon_array = [
	"red_balloon",
	"blue_balloon",
	"green_balloon",
	"yellow_balloon",
	"pink_balloon",
	"black_balloon",
	"white_balloon",
	"rainbow_balloon",
	"ceramic_balloon"]
	
	balloon.spawn_balloon(balloon_array[rng.randi_range(0, len(balloon_array)-1)], $BalloonPath, 0.0)
