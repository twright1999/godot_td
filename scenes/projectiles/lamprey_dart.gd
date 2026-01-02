extends Node2D

@onready var projectile = $ProjectileComponent

func _physics_process(delta: float) -> void:
	position += projectile.move(rotation, delta)

func _on_projectile_component_lifetime_expired() -> void:
	queue_free()
