extends Node2D

@onready var projectile = $ProjectileComponent

func _physics_process(delta: float) -> void:
	position += projectile.move(rotation, delta)
	if projectile.is_lifetime_expired():
		queue_free()
