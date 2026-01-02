extends Node2D

@export var fire_interval := 1.0
@export var projectile_scene: PackedScene

signal fire_projectile(projectile: Node)

@onready var turret_timer = $Timer
@onready var turret_dart_origin = $DartOrigin

func _ready():
	turret_timer.wait_time = fire_interval
	turret_timer.start()

func _on_timer_timeout() -> void:
	if projectile_scene:
		fire()
	
func fire() -> void:
	var projectile = projectile_scene.instantiate()
	projectile.position = turret_dart_origin.global_position
	projectile.rotation = rotation
	fire_projectile.emit(projectile)
