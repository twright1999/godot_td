extends HBoxContainer

func _on_debug_damage_pressed() -> void:
	MoneyHealthManager.take_health(50)

func _on_debug_add_money_pressed() -> void:
	MoneyHealthManager.add_money(200)

func _on_debug_speed_up_pressed() -> void:
	if Engine.time_scale == 10:
		Engine.time_scale = 1
		Engine.physics_ticks_per_second = 60
	else:
		Engine.time_scale = 10
		Engine.physics_ticks_per_second = 600
