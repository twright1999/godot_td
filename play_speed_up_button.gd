extends Button

enum ButtonState {
	PLAY,
	SPEEDUP_NORMAL,
	SPEEDUP_FAST
}

var texture_map = {
	ButtonState.PLAY : preload("res://assets/sprites/menu/right.png"),
	ButtonState.SPEEDUP_NORMAL : preload("res://assets/sprites/menu/fastForward_1.png"),
	ButtonState.SPEEDUP_FAST : preload("res://assets/sprites/menu/fastForward_2.png")
}

var current_state: ButtonState = ButtonState.PLAY
signal set_speedup_normal
signal set_speedup_fast

func _ready():
	update_visuals()
	GameEvents.wave_finished.connect(wave_finished)

func update_visuals():
	self.icon = texture_map[current_state]

func _pressed():
	match current_state:
		ButtonState.PLAY:
			set_state(ButtonState.SPEEDUP_NORMAL)
			GameEvents.wave_start_requested.emit()
		ButtonState.SPEEDUP_NORMAL:
			set_state(ButtonState.SPEEDUP_FAST)
			set_speedup_fast.emit()
		ButtonState.SPEEDUP_FAST:
			set_state(ButtonState.SPEEDUP_NORMAL)
			set_speedup_normal.emit()
	
func wave_finished():
	set_state(ButtonState.PLAY)

func set_state(new_state : ButtonState):
	current_state = new_state
	update_visuals()
