extends Area2D

@export var lifetime := 0.5
@export var projectile_damage : int
@export var speed : int
@export var damage_type : DataTypes.Resistance

signal lifetime_expired

@onready var lifetime_timer = $Timer

func _ready():
	lifetime_timer.wait_time = lifetime
	lifetime_timer.start()
	
func _on_timer_timeout() -> void:
	lifetime_expired.emit()

func move(projectile_rotation, delta) -> Vector2:
	return Vector2(1, 0).rotated(projectile_rotation) * speed * delta
