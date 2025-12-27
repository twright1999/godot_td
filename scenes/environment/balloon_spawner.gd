extends Node2D

@export var waves: Array[WaveData]

var balloon_scene: PackedScene = load("res://scenes/balloons/balloon.tscn")
var balloon = balloon_scene.instantiate()
var rng := RandomNumberGenerator.new()

##
## Balloon spawning
##
#func _on_balloon_timer_timeout() -> void:
	#spawn_random_balloon()

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

func _on_world_ready() -> void:
	for wave in waves:
		# Waits for the current wave to finish spawning before
		# calling the next wave.
		await run_wave(wave)
		
func run_wave(wave: WaveData) -> void:
	for group in wave.groups:
		# Waits for group to finish spawning.
		await spawn_group(group)
		await get_tree().create_timer(wave.group_delay).timeout
	
func spawn_group(group: BalloonGroup) -> void:
	for i in group.count:
		balloon.spawn_balloon(group.balloon_type, $BalloonPath, 0.0)
		await get_tree().create_timer(group.delay).timeout
