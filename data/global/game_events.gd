extends Node

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
