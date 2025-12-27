extends Node2D

var scale_tween: Tween
var lamprey_dart_scene: PackedScene = load("res://scenes/projectiles/lamprey_dart.tscn")

var balloons_in_range := []
var lamprey_active = false

var built = false
var build_colliding = true

func _process(_delta: float) -> void:
	balloons_in_range = $Range.get_overlapping_areas()
	if built:
		if not balloons_in_range.is_empty():
			set_lamprey_active(true)
			target_balloon()
		else:
			set_lamprey_active(false)
	else:
		check_build_collisions()

func set_lamprey_active(active: bool):
	if active == lamprey_active:
		return
		
	lamprey_active = active

	if scale_tween:
		scale_tween.kill()
		
	scale_tween = create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	
	if lamprey_active:
		scale_tween.tween_property($SpriteLamprey, "scale", Vector2(0.7, 0.7), 0.3)
	else:
		scale_tween.tween_interval(1)
		scale_tween.tween_property($SpriteLamprey, "scale", Vector2(0, 0), 0.3)

func target_balloon():
	var highest_progress = 0
	var targeted_balloon = null
	for balloon in balloons_in_range:
		var balloon_progress = balloon.get_parent().progress_ratio
		if balloon_progress > highest_progress:
			highest_progress = balloon_progress
			targeted_balloon = balloon
	$SpriteLamprey.look_at(targeted_balloon.global_transform.origin)

func check_build_collisions():
	if $BuildRadius.get_overlapping_areas().is_empty():
		build_colliding = false
	else:
		build_colliding = true

func _on_timer_timeout() -> void:
	if not balloons_in_range.is_empty() and built:
		var lamprey_dart = lamprey_dart_scene.instantiate()
		lamprey_dart.position = $SpriteLamprey/DartOrigin.global_position
		lamprey_dart.rotation = $SpriteLamprey.rotation
		get_node("../../Projectiles").add_child(lamprey_dart)
