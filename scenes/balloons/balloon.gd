extends PathFollow2D

var balloon_type
var health
var speed

func _init() -> void:
	self.balloon_type = "red_balloon"
	self.health = 1
	self.speed = 0

func _process(delta: float) -> void:
	move_balloon(delta)

func _on_area_2d_area_entered(area: Area2D) -> void:
	pop_balloon()
	area.queue_free()

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
	# Kills current balloon and prints debug message
	print(balloon_type, " reached the exit")
	queue_free()
	
##
## Balloon popping logic
##
func pop_balloon() -> void:
	if BalloonData.balloon_data[balloon_type]["contains"].is_empty():
		# If balloon contains no other balloons (red), kill balloon
		queue_free()
	elif len(BalloonData.balloon_data[balloon_type]["contains"]) == 1:
		# If balloon contains 1 other balloon, become that balloon
		var new_balloon = BalloonData.balloon_data[balloon_type]["contains"][0]
		update_balloon_type(new_balloon)
	else:
		# TODO If balloon contains multiple balloons, spawn balloons
		pass

	# Kills current balloon and prints debug message
	print(balloon_type, " was popped")

func update_balloon_type(new_balloon_type: String) -> void:
	self.balloon_type = new_balloon_type
	self.health = BalloonData.balloon_data[new_balloon_type]["health"]
	self.speed = BalloonData.balloon_data[new_balloon_type]["speed"]
	$Sprite2D.texture = load(BalloonData.balloon_data[new_balloon_type]["sprite_path"])
