extends CharacterBody2D


@export var speed := 500

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position = Vector2(100, 200)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var movement_vector = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	position += movement_vector * speed * delta
