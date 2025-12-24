extends Node2D

var lamprey_dart_scene: PackedScene = load("res://scenes/projectiles/lamprey_dart.tscn")

func _on_lamprey_tower_dart(pos, rot) -> void:
	var lamprey_dart = lamprey_dart_scene.instantiate()
	lamprey_dart.position = pos
	lamprey_dart.rotation = rot
	$Darts.add_child(lamprey_dart)
	
