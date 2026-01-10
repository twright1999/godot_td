extends CanvasLayer

signal game_over_restart()
signal game_over_main_menu()

func _on_restart_pressed() -> void:
	game_over_restart.emit()
	
func _on_main_menu_pressed() -> void:
	game_over_main_menu.emit()
