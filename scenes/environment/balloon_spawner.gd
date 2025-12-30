extends Node2D

var balloon_scene: PackedScene = load("res://scenes/balloons/balloon.tscn")
var pop_scene: PackedScene = load("res://scenes/sounds/pop_sfx.tscn")

@export var waves: Array[WaveData]

const dispersion = 0.002

const BalloonDict = {
	DataTypes.Balloon.RED : preload("res://data/balloons/red.tres"),
	DataTypes.Balloon.BLUE : preload("res://data/balloons/blue.tres"),
	DataTypes.Balloon.GREEN : preload("res://data/balloons/green.tres"),
	DataTypes.Balloon.YELLOW : preload("res://data/balloons/yellow.tres"),
	DataTypes.Balloon.PINK : preload("res://data/balloons/pink.tres"),
	DataTypes.Balloon.BLACK : preload("res://data/balloons/black.tres"),
	DataTypes.Balloon.WHITE : preload("res://data/balloons/white.tres"),
	DataTypes.Balloon.ZEBRA : preload("res://data/balloons/zebra.tres"),
	DataTypes.Balloon.LEAD : preload("res://data/balloons/lead.tres"),
	DataTypes.Balloon.RAINBOW : preload("res://data/balloons/rainbow.tres"),
	DataTypes.Balloon.CERAMIC : preload("res://data/balloons/ceramic.tres"),
}
##
## Balloon Spawning
##
func _on_spawn_child_balloons(progress_ratio, contains_list, residual_damage):
	# Apply residual damage from balloon pop to contained balloons
	var spawn_list = calculate_balloons_after_residual_damage(contains_list.duplicate(), residual_damage)
	
	# Get list of dispersions for evenly distributed children
	var dispersion_list = get_evenly_distributed_range(len(spawn_list))
	
	# Spawn children balloons at given dispersions
	for i in len(spawn_list):
		spawn_balloon(spawn_list[i], $BalloonPath, dispersion_list[i] * dispersion + progress_ratio)

func get_evenly_distributed_range(n : float) -> Array:
	# Given n, returns an array of n items distributed evenly between -1 and 1
	# E.g.
	# n = 0 returns []
	# n = 1 returns [0]
	# n = 2 returns [-1, 1]
	# n = 3 returns [-1, 0, -1]
	# Used for distributing spawned balloons uniformly along path
	if n <= 0:
		return []
	elif n == 1:
		return [0]
	else:
		var distributed_range = []
		for i in range(n):
			distributed_range.append(-1 + i * (2/(n-1)))
		return distributed_range

func calculate_balloons_after_residual_damage(spawn_list, residual_damage) -> Array:
	# If no balloons in spawn list to damage, return empty list
	if spawn_list == []:
		return []
	# If no more damage to apply, return current spawn list
	elif residual_damage == 0:
		return spawn_list
	else:
		var back_balloon = spawn_list.pop_back()
		var back_balloon_health = BalloonDict[back_balloon].health
		# If residual damage would pop back balloon in spawn list, reapply
		#	residual damage calculation to spawn list with a popped back balloon
		if residual_damage >= back_balloon_health:
			var contained_balloons = BalloonDict[back_balloon].contains
			spawn_list.append_array(contained_balloons)
			return calculate_balloons_after_residual_damage(spawn_list, residual_damage - back_balloon_health)
		# If residual damage cannot pop back balloon, return current spawn list
		else:
			spawn_list.append(back_balloon)
			return spawn_list

func spawn_balloon(new_balloon_type: DataTypes.Balloon, parent_path: Path2D, new_progress_ratio: float):
	var new_balloon = balloon_scene.instantiate()
	
	# Sets new balloon attributes before parenting to path
	new_balloon.balloon_stats = BalloonDict[new_balloon_type]
	new_balloon.balloon_type = new_balloon_type
	
	# Progress cannot be immediately set as balloon is not yet child to path
	# 	so set intermediate "ready" progress before adding child
	new_balloon.ready_progress = new_progress_ratio
	
	# Connect signals used for popping and reaching exit detection
	new_balloon.connect("spawn_child_balloons", _on_spawn_child_balloons)
	new_balloon.connect("reach_exit", _on_balloon_reaches_exit)
	
	# Set new balloon as child of Path2D, which calls _ready function and sets
	# 	progress to ready_progress set above
	parent_path.call_deferred("add_child", new_balloon)

##
## Balloon Waves
##
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
		spawn_balloon(group.balloon_type, $BalloonPath, 0.0)
		await get_tree().create_timer(group.delay).timeout

##
## Balloon reaches exit
##
func _on_balloon_reaches_exit(balloon_type):
	print(balloon_type, " reached exit, damage for ", calculate_damage_balloon_deals(balloon_type))

func calculate_damage_balloon_deals(balloon_type):
	var total_score = BalloonDict[balloon_type].health
	var contains_list = BalloonDict[balloon_type].contains
	
	if len(contains_list) == 0:
		return BalloonDict[balloon_type].health
	else:
		for contained_balloon in contains_list:
			total_score += calculate_damage_balloon_deals(BalloonDict[contained_balloon])
	return total_score
