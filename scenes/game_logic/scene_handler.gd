extends Node

var playback:AudioStreamPlaybackPolyphonic

var click_sfx = preload("res://assets/audio/sound_effects/click.ogg")
var hover_sfx = preload("res://assets/audio/sound_effects/hover.ogg")
var honk_sfx = preload("res://assets/audio/sound_effects/honk.ogg")

func _ready():
	$MainMenu.connect("play_pressed", load_game)
	$MainMenu.connect("honk_pressed", on_honk_pressed)
	MoneyHealthManager.connect("game_over", on_game_over)

func load_game():
	var game_scene = load("res://scenes/game_logic/game_scene.tscn").instantiate()
	add_child(game_scene)

func on_game_over():
	var game_over_scene = load("res://scenes/ui/game_over_screen.tscn").instantiate()
	add_child(game_over_scene)
	game_over_scene.connect("game_over_restart", on_game_over_restart)
	game_over_scene.connect("game_over_main_menu", on_game_over_main_menu)
	
func on_game_over_restart():
	get_node("GameOverScreen").queue_free()
	get_node("GameScene").free()
	var game_scene = load("res://scenes/game_logic/game_scene.tscn").instantiate()
	add_child(game_scene)

func on_game_over_main_menu():
	get_node("GameOverScreen").queue_free()
	get_node("GameScene").free()
	var main_menu = load("res://scenes/ui/main_menu.tscn").instantiate()
	add_child(main_menu)
	main_menu.connect("play_pressed", load_game)
	main_menu.connect("honk_pressed", on_honk_pressed)

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
		node.mouse_entered.connect(_set_cursor_hover)
		node.mouse_exited.connect(_set_cursor_default)
		node.pressed.connect(_play_pressed_sound)

func _play_hover_sound() -> void:
	playback.play_stream(hover_sfx, 0, -10, randf_range(0.9, 1.1))

func _play_pressed_sound() -> void:
	playback.play_stream(click_sfx, 0, -10, randf_range(0.9, 1.1))
	
func _set_cursor_hover() -> void:
	CursorHandler.set_state(CursorHandler.CursorState.HOVER)

func _set_cursor_default() -> void:
	CursorHandler.set_state(CursorHandler.CursorState.DEFAULT)

func on_honk_pressed():
	playback.play_stream(honk_sfx, 0, -10, 1)
