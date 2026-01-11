extends Node2D

var projectile_container: Node2D		## World scene container for projectiles

@onready var targeting = $TargetingComponent
@onready var base = $BaseComponent

@export var proj_count := 8

var target = null

func _physics_process(_delta: float) -> void:
	if base.built:
		target = targeting.get_target()

func _on_turret_component_fire_projectile(projectile: Node) -> void:
	if base.built and target:
		spawn_fireballs(proj_count, projectile)
		
func spawn_fireballs(count: int, proj: Node) -> void:
	for angle in range(0, 360, 360.0/count):
		var new_proj = proj.duplicate()
		new_proj.rotation = deg_to_rad(angle)
		projectile_container.add_child(new_proj)
