extends Node2D

@onready var projectile = $ProjectileComponent
@onready var sprite = $Sprite2D

var rotate_speed = 50

func _physics_process(delta: float) -> void:
	position += projectile.move(rotation, delta)
	sprite.rotation += rotate_speed * delta

func _on_projectile_component_lifetime_expired() -> void:
	queue_free()
