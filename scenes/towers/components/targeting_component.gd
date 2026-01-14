extends Area2D

var targets_in_range: Array[Node2D] = []
var targeting_mode := DataTypes.Targeting_Mode.FIRST

@export var camo_detection := false :
	set(value):
		reacquire_targets()
		camo_detection = value

func _on_area_entered(area: Area2D) -> void:
	var balloon = area.get_parent()
	if not balloon.camo or camo_detection:
		targets_in_range.append(area.get_parent())
	
func _on_area_exited(area: Area2D) -> void:
	targets_in_range.erase(area.get_parent())

func reacquire_targets() -> void:
	# Called when camo_detection or similar is changed
	targets_in_range = []
	for area in get_overlapping_areas():
		var balloon = area.get_parent()
		if not balloon.camo or camo_detection:
			targets_in_range.append(balloon)

func get_target() -> Node2D:
	var target = Node2D
	match targeting_mode:
		DataTypes.Targeting_Mode.FIRST:
			target = get_first_target()
		DataTypes.Targeting_Mode.LAST:
			target = get_last_target()
		DataTypes.Targeting_Mode.WEAK:
			target = get_weakest_target()
		DataTypes.Targeting_Mode.STRONG:
			target = get_strongest_target()
	return target

func get_first_target() -> Node2D:
	var highest_progress = 0
	var target_balloon = null
	for balloon in targets_in_range:
		if balloon.progress_ratio > highest_progress:
			highest_progress = balloon.progress_ratio
			target_balloon = balloon
	return target_balloon
			
func get_last_target() -> Node2D:
	var lowest_progress = 1
	var target_balloon = null
	for balloon in targets_in_range:
		if balloon.progress_ratio < lowest_progress:
			lowest_progress = balloon.progress_ratio
			target_balloon = balloon
	return target_balloon

func get_weakest_target() -> Node2D:
	var lowest_strength = 20
	var target_balloon = null
	for balloon in targets_in_range:
		if balloon.strength < lowest_strength:
			lowest_strength = balloon.strength
			target_balloon = balloon
	return target_balloon
	
func get_strongest_target() -> Node2D:
	var highest_strength = 0
	var target_balloon = null
	for balloon in targets_in_range:
		if balloon.strength > highest_strength:
			highest_strength = balloon.strength
			target_balloon = balloon
	return target_balloon
