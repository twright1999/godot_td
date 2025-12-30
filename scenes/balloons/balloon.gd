extends PathFollow2D

var balloon_stats = Resource

var balloon_type
var health
var speed
var contains = []
var resistances = []

var ready_progress
var dispersion = 0.002

signal spawn_child_balloons(progress_ratio, contains_list, residual_damage)
signal reach_exit(balloon_type)

func _ready() -> void:
	progress_ratio = ready_progress
	health = balloon_stats.health
	speed = balloon_stats.speed
	$Sprite2D.texture = balloon_stats.sprite
	contains = balloon_stats.contains
	resistances = balloon_stats.resistances

func _process(delta: float) -> void:
	move_balloon(delta)

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.damage_type not in resistances:
		damage_balloon(area.projectile_damage)
	area.free()

##
## Balloon moving logic
##
func move_balloon(delta: float) -> void:
	# Move balloon along path according to SPEED
	progress_ratio += speed * delta

	# Handle logic if balloon reaches end of path
	if progress_ratio >= 1.0:
		balloon_reaches_end()

func balloon_reaches_end() -> void:
	reach_exit.emit(balloon_type)
	# Kills balloon
	queue_free()
	
	# Uncomment for reaching end debug
	# print(balloon_type, " reached the exit")

##
## Balloon damaging logic
##
func damage_balloon(damage: int):
	if damage >= health:
		spawn_child_balloons.emit(progress_ratio, contains, damage - health)
		queue_free()
	else:
		health -= damage
