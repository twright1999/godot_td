extends PathFollow2D

var ceramic_tap_scene: PackedScene = load("res://scenes/sounds/ceramic_tap.tscn")

var balloon_stats = Resource

var balloon_type
var health
var speed
var contains = []
var resistances = []
var strength
var sprite_index := 0
var attributes := {
	"camo" : false,
	"regrow" : false,
	"fortified" : false
}
var regrow_path : Array[DataTypes.Balloon]

var ready_progress
var dispersion = 0.002

signal spawn_child_balloons(current_balloon, progress_ratio, contains_list, residual_damage, attributes, regrow_path)
signal spawn_regrow_balloon(new_balloon, progress_ratio, attributes, regrow_path)
signal reach_exit(balloon_type)

func _ready() -> void:
	progress_ratio = ready_progress
	health = balloon_stats.health
	speed = balloon_stats.speed
	contains = balloon_stats.contains
	resistances = balloon_stats.resistances
	strength = balloon_stats.strength
	$Area2D/CollisionShape2D.disabled = true
	$CamoMask.visible = attributes.camo
	
	if attributes.regrow:
		$Sprite2D.texture = balloon_stats.sprites_regrow[0]
		$RegrowTimer.start()
	else:
		$Sprite2D.texture = balloon_stats.sprites[0]

func _process(delta: float) -> void:
	move_balloon(delta)

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.damage_type not in resistances:
		damage_balloon(area.projectile_damage)
	area.get_parent().free()

##
## Balloon moving logic
##
func move_balloon(delta: float) -> void:
	# Move balloon along path according to SPEED
	progress_ratio += speed * delta * 2

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
		regrow_path.push_front(balloon_type)
		spawn_child_balloons.emit(balloon_type, progress_ratio, contains, damage - health, attributes, regrow_path)
		queue_free()
	else:
		health -= damage
		if balloon_type == DataTypes.Balloon.CERAMIC:
			update_ceramic_sprite()
			play_ceramic_tap()

func update_ceramic_sprite():
	var new_sprite_index = 0
	
	match health:
		8, 7:
			new_sprite_index = 1
		6, 5:
			new_sprite_index = 2
		4, 3:
			new_sprite_index = 3
		2, 1:
			new_sprite_index = 4
	
	if new_sprite_index != sprite_index:
		sprite_index = new_sprite_index
		$Sprite2D.texture = balloon_stats.sprites[sprite_index]

func play_ceramic_tap():
	add_child(ceramic_tap_scene.instantiate())


func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	$Area2D/CollisionShape2D.disabled = false


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	$Area2D/CollisionShape2D.disabled = true


func _on_regrow_timer_timeout() -> void:
	if not regrow_path.is_empty():
		var new_balloon_type = regrow_path.pop_front()
		spawn_regrow_balloon.emit(new_balloon_type, progress_ratio, attributes, regrow_path)
		queue_free()
