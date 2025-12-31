extends Node2D

@export var projectile_container: Node2D		## World scene container for projectiles

@onready var targeting = $TargetingComponent
@onready var base = $BaseComponent

var scale_tween: Tween

var lamprey_active = true
var built = false

func _physics_process(_delta: float) -> void:
	if built:
		var target = targeting.get_first_target()
		if target:
			set_lamprey_active(true)
			$TurretComponent.look_at(target.global_position)
		else:
			set_lamprey_active(false)

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
		scale_tween.tween_property($TurretComponent/Sprite2D, "scale", Vector2(0.5, 0.5), 0.5)
	else:
		# Wait a while, then slowly revert to 0 scale
		scale_tween.tween_interval(1)
		scale_tween.set_trans(Tween.TRANS_LINEAR)
		scale_tween.tween_property($TurretComponent/Sprite2D, "scale", Vector2(0, 0), 1)

func _on_turret_component_fire_projectile(projectile: Node) -> void:
	if built and lamprey_active:
		projectile_container.add_child(projectile)
