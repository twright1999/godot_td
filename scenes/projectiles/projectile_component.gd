extends Area2D

@export var projectile_damage : int
@export var speed : int
@export var damage_type : DataTypes.Resistance
@export var projectile : Node2D
@export var lifetime : float

func move(projectile_rotation, delta) -> Vector2:
	return Vector2(1, 0).rotated(projectile_rotation) * speed * delta

func is_lifetime_expired() -> bool:
	return $Timer.is_stopped()
