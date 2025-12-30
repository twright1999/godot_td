extends Node2D

@onready var targeting = $TargetingComponent

var scale_tween: Tween
var lamprey_dart_scene: PackedScene = load("res://scenes/projectiles/lamprey_dart.tscn")

var balloons_in_range := []
var lamprey_active = false

var built = true
var build_colliding = true

func _process(_delta: float) -> void:
	#balloons_in_range = $Range.get_overlapping_areas()
	if built:
		#if not balloons_in_range.is_empty():
		set_lamprey_active(true)
		var target = targeting.get_first_target()
		
		if target:
			print(target)
			$SpriteLamprey.look_at(target)
			
		#else:
			#set_lamprey_active(false)
	else:
		check_build_collisions()

func set_lamprey_active(active: bool):
	# If active state matches what it is already set to, do nothing
	if active == lamprey_active:
		return
	
	# Set the new state
	lamprey_active = active

	# If already animating, kill previous animation
	if scale_tween:
		scale_tween.kill()
	
	# Create a tween
	scale_tween = create_tween().set_ease(Tween.EASE_OUT)
	
	if lamprey_active:
		# Set scale to 0.5, 0.5 quickly and elastically
		scale_tween.set_trans(Tween.TRANS_ELASTIC)
		scale_tween.tween_property($SpriteLamprey, "scale", Vector2(0.5, 0.5), 0.5)
	else:
		# Wait a while, then slowly revert to 0 scale
		scale_tween.tween_interval(1)
		scale_tween.set_trans(Tween.TRANS_LINEAR)
		scale_tween.tween_property($SpriteLamprey, "scale", Vector2(0, 0), 1)

#func target_balloon():
	#var highest_progress = 0
	#var targeted_balloon = null
	#for balloon in balloons_in_range:
		#var balloon_progress = balloon.get_parent().progress_ratio
		#if balloon_progress > highest_progress:
			#highest_progress = balloon_progress
			#targeted_balloon = balloon
	#$SpriteLamprey.look_at(targeted_balloon.global_transform.origin)

func check_build_collisions():
	#if $BuildRadius.get_overlapping_areas().is_empty():
		#build_colliding = false
	#else:
		#build_colliding = true
	build_colliding = false

func _on_timer_timeout() -> void:
	if not balloons_in_range.is_empty() and built:
		var lamprey_dart = lamprey_dart_scene.instantiate()
		lamprey_dart.position = $SpriteLamprey/DartOrigin.global_position
		lamprey_dart.rotation = $SpriteLamprey.rotation
		get_node("../../Projectiles").add_child(lamprey_dart)
