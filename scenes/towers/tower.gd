extends Node2D

@export var stats: TowerStats

var balloons_in_range := []

var built = false
var build_colliding = true
var projectile_scene: PackedScene

func _ready():
	$Range/RangeCollision.shape.radius = stats.tower_radius
	$TowerBase.texture = stats.base_texture
	$TowerTurret.texture = stats.turret_texture
	$TowerTurret/Timer.wait_time = stats.tower_rof
	$BuildRadius/BuildRadiusCollision.shape.radius = stats.tower_build_radius
	projectile_scene = load("res://scenes/projectiles/lamprey_dart.tscn")

func _process(_delta: float) -> void:
	balloons_in_range = $Range.get_overlapping_areas()
	if built:
		if not balloons_in_range.is_empty():
			target_balloon()
	else:
		check_build_collisions()

func target_balloon():
	var highest_progress = 0
	var targeted_balloon = null
	for balloon in balloons_in_range:
		var balloon_progress = balloon.get_parent().progress_ratio
		if balloon_progress > highest_progress:
			highest_progress = balloon_progress
			targeted_balloon = balloon
	$TowerTurret.look_at(targeted_balloon.global_transform.origin)

func check_build_collisions():
	if $BuildRadius.get_overlapping_areas().is_empty():
		build_colliding = false
	else:
		build_colliding = true

func _on_timer_timeout() -> void:
	if not balloons_in_range.is_empty() and built:
		var projectile = projectile_scene.instantiate()
		projectile.position = $TowerTurret/DartOrigin.global_position
		projectile.rotation = $TowerTurret.rotation
		get_node("../../Projectiles").add_child(projectile)
