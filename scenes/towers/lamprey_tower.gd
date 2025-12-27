extends Node2D

var lamprey_dart_scene: PackedScene = load("res://scenes/projectiles/lamprey_dart.tscn")

var balloons_in_range := []

var shrink_speed = 0.7
var grow_speed = 2
var built = false
var build_colliding = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	balloons_in_range = $Range.get_overlapping_areas()
	if built and not balloons_in_range.is_empty():
		show_lamprey(delta)
		
		var highest_progress = 0
		var targeted_balloon = null
		for balloon in balloons_in_range:
			var balloon_progress = balloon.get_parent().progress_ratio
			if balloon_progress > highest_progress:
				highest_progress = balloon_progress
				targeted_balloon = balloon
		$SpriteLamprey.look_at(targeted_balloon.global_transform.origin)
	elif $SpriteLamprey.visible:
		hide_lamprey(delta)

	if not built:
		check_build_collisions()
		
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
		
func hide_lamprey(delta) -> void:
	if $SpriteLamprey.scale >= Vector2(0.0, 0.0) and $SpriteLamprey.visible:
		$SpriteLamprey.scale -= Vector2(shrink_speed, shrink_speed) * delta
	else:
		$SpriteLamprey.hide()

func show_lamprey(delta) -> void:
	if not $SpriteLamprey.visible:
		$SpriteLamprey.show()
	if $SpriteLamprey.scale <= Vector2(0.5, 0.5):
		$SpriteLamprey.scale += Vector2(grow_speed, grow_speed) * delta
