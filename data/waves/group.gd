class_name BalloonGroup
extends Resource

@export var count: int
@export var balloon_type: DataTypes.Balloon
@export var delay: float
@export var attributes := {
	"camo" : false,
	"regrow" : false,
	"fortified" : false
}
