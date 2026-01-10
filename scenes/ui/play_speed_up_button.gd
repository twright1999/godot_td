extends TextureButton

enum ButtonState {
	PLAY,
	SPEEDUP_NORMAL,
	SPEEDUP_FAST
}

var texture_map = {
	ButtonState.PLAY : {
		"normal" : preload("res://assets/ui/play_speedup_button/buttonSquare_beige_play.png"),
		"hover": preload("res://assets/ui/play_speedup_button/buttonSquare_beige_play_hover.png"),
		"pressed" : preload("res://assets/ui/play_speedup_button/buttonSquare_beige_play_pressed.png"),
		},
	ButtonState.SPEEDUP_NORMAL : {
		"normal" : preload("res://assets/ui/play_speedup_button/buttonSquare_beige_ff_normal.png"),
		"hover": preload("res://assets/ui/play_speedup_button/buttonSquare_beige_ff_normal_hover.png"),
		"pressed" : preload("res://assets/ui/play_speedup_button/buttonSquare_beige_ff_normal_pressed.png"),
		},
	ButtonState.SPEEDUP_FAST : {
		"normal" : preload("res://assets/ui/play_speedup_button/buttonSquare_beige_ff_fast.png"),
		"hover": preload("res://assets/ui/play_speedup_button/buttonSquare_beige_ff_fast_hover.png"),
		"pressed" : preload("res://assets/ui/play_speedup_button/buttonSquare_beige_ff_fast_pressed.png"),
		},
}

var current_state: ButtonState = ButtonState.PLAY
signal set_speedup_normal
signal set_speedup_fast

func _ready():
	update_visuals()
	GameEvents.wave_finished.connect(wave_finished)

func update_visuals():
	self.texture_normal = texture_map[current_state]["normal"]
	self.texture_hover = texture_map[current_state]["hover"]
	self.texture_pressed = texture_map[current_state]["pressed"]

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
	if not GameEvents.auto_start:
		set_state(ButtonState.PLAY)

func set_state(new_state : ButtonState):
	current_state = new_state
	update_visuals()
