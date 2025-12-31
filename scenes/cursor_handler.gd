extends Node

enum CursorState {
	DEFAULT,
	GRAB,
	HOVER,
}

@export var default_cursor: Texture2D
@export var grab_cursor: Texture2D
@export var hover_cursor: Texture2D

var current_state: CursorState = CursorState.DEFAULT

func _ready():
	apply_cursor(CursorState.DEFAULT)

func set_state(state: CursorState):
	if current_state == state:
		return
	current_state = state
	apply_cursor(state)

func apply_cursor(state: CursorState) -> void:
	match state:
		CursorState.DEFAULT:
			Input.set_custom_mouse_cursor(default_cursor)
		CursorState.GRAB:
			Input.set_custom_mouse_cursor(grab_cursor)
		CursorState.HOVER:
			Input.set_custom_mouse_cursor(hover_cursor)
