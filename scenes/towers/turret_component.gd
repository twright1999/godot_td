extends Node2D

@onready var TurretRange = $Range
@onready var TurretTimer = $Timer
@onready var TurretDartOrigin = $DartOrigin

func _ready():
	pass
	#$Range/CollisionShape2D.radius = TurretRange
	#$Timer.wait_time = 1/TurretRoundsPerSecond
	#$DartOrigin.position = ProjectileOffset
