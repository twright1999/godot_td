class_name BalloonData
extends Resource

enum Balloon {
	Invalid,
	Red,
	Blue,
	Green,
	Yellow,
	Pink,
	Black,
	White,
	Zebra,
	Rainbow,
	Lead,
	Ceramic
} 

enum Resistance {
	Normal,
	Explosion,
	Freeze
}

@export var name: Balloon = Balloon.Invalid
@export var health: int = 1
@export var speed: float = 0.0
@export var sprite: Texture2D
@export var contains: Array[Balloon]
@export var resistances: Array[Resistance]
