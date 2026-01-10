extends Control

signal play_pressed()
signal honk_pressed()

func _enter_tree():
	Engine.physics_ticks_per_second = 60
	Engine.time_scale = 1

func on_play_pressed():
	queue_free()
	play_pressed.emit()

func on_quit_pressed():
	get_tree().quit()

func _on_honk_joe_pressed() -> void:
	honk_pressed.emit()

func _on_honk_tom_pressed() -> void:
	honk_pressed.emit()
