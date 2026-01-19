extends TextureButton


var button_texture : TextureRect
@export var tower_scene : PackedScene
var displayed_cost : int

func _ready():
	var tower = tower_scene.instantiate()
	displayed_cost = tower.get_node("BaseComponent").tower_cost
	$TextureRect.texture = tower.get_node("TurretComponent/Sprite2D").texture
	$Label.text = str(displayed_cost)
