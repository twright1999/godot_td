extends Node2D

@export var TurretTexture: Texture2D
@export var TurretRange: float
@export var TurretRoundsPerSecond: float
@export var ProjectileOffset: Vector2

func _init():
	$TurretSprite.texture = TurretTexture
	$Range/CollisionShape2D.radius = TurretRange
	$Timer.wait_time = 1/TurretRoundsPerSecond
	$DartOrigin.position = ProjectileOffset
