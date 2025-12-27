extends Node

func _ready():
	get_node("MainMenu/Margin/VBoxContainer/Play").pressed.connect(on_play_pressed)
	get_node("MainMenu/Margin/VBoxContainer/Quit").pressed.connect(on_quit_pressed)

func on_play_pressed():
	get_node("MainMenu").queue_free()
	var game_scene = load("res://scenes/game_scene.tscn").instantiate()
	add_child(game_scene)

func on_quit_pressed():
	get_tree().quit()
