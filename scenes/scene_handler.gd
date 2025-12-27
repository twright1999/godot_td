extends Node

var playback:AudioStreamPlaybackPolyphonic

func _ready():
	get_node("MainMenu/Margin/VBoxContainer/Play").pressed.connect(on_play_pressed)
	get_node("MainMenu/Margin/VBoxContainer/Quit").pressed.connect(on_quit_pressed)

func on_play_pressed():
	get_node("MainMenu").queue_free()
	var game_scene = load("res://scenes/game_scene.tscn").instantiate()
	add_child(game_scene)

func on_quit_pressed():
	get_tree().quit()

##
## Button Sounds
##
func _enter_tree() -> void:
	# Create an audio player
	var player = AudioStreamPlayer.new()
	add_child(player)

	# Create a polyphonic stream so we can play sounds directly from it
	var stream = AudioStreamPolyphonic.new()
	stream.polyphony = 32
	player.stream = stream
	player.play()
	# Get the polyphonic playback stream to play sounds
	playback = player.get_stream_playback()

	get_tree().node_added.connect(_on_node_added)

func _on_node_added(node:Node) -> void:
	if node is TextureButton:
		# If the added node is a button we connect to its mouse_entered and pressed signals
		# and play a sound
		node.mouse_entered.connect(_play_hover_sound)
		node.pressed.connect(_play_pressed_sound)

func _play_hover_sound() -> void:
	playback.play_stream(preload("res://assets/audio/sound_effects/hover.ogg"), 0, 0, randf_range(0.9, 1.1))

func _play_pressed_sound() -> void:
	playback.play_stream(preload("res://assets/audio/sound_effects/click.ogg"), 0, 0, randf_range(0.9, 1.1))
