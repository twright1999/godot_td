extends Node

var auto_start = false

@warning_ignore("unused_signal")
signal wave_start_requested
signal wave_finished

var wave_running : bool:
	get:
		return wave_running
	set(value):
		if wave_running and not value:
			wave_finished.emit()
		wave_running = value
		

func _ready():
	connect("wave_finished", _on_wave_finished)

func _on_wave_finished():
	if auto_start:
		wave_start_requested.emit()
