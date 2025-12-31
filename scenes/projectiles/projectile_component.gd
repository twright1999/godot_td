extends Area2D

@export var projectile_damage : int
@export var speed : int
@export var damage_type : DataTypes.Resistance

@export var lifetime : float
@onready var lifetime_timer = $Timer

signal lifetime_expired

func ready():
	lifetime_timer.wait_time = lifetime

func move(projectile_rotation, delta) -> Vector2:
	return Vector2(1, 0).rotated(projectile_rotation) * speed * delta

func _on_timer_timeout() -> void:
	print("timer expired")
	lifetime_expired.emit()
