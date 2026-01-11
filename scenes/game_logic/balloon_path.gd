extends Path2D

var children_balloons = 0

signal no_children

func _physics_process(_delta: float) -> void:
	if children_balloons == 0:
		no_children.emit()

func _on_child_exiting_tree(node: Node) -> void:
	if node is PathFollow2D:
		children_balloons -= 1

func _on_child_entered_tree(node: Node) -> void:
	if node is PathFollow2D:
		children_balloons += 1
		
