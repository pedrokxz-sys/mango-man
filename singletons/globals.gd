extends Node

signal health_changed

var min:= 3
var seg:= 0

var mangos:= 0 

var score:= 0

var health:= 6

var player = null

var player_start_position = null

var current_checkpoint = null

var last_home : String = ""

var can_use_long_collect = false

var can_attack:bool = true

var is_run:bool = true

var dialog_is_on = false
var dialog_direction:int = 1

var screen_ratio: float = 16.0 / 9.0

func respawn_player():
	if current_checkpoint != null:
		player.position = current_checkpoint.global_position
	else:
		player.global_position = player_start_position.global_position

func _physics_process(_delta: float) -> void:
	if Cutscenes._04_town_finished:
		can_use_long_collect = true

func _ready() -> void:
	var config = ConfigFile.new()
	var error = config.load("user://settings.cfg")

	if error == OK:
		screen_ratio = config.get_value("display", "screen_ratio", 0.0)
	else:
		screen_ratio = 0.0

	apply_screen_ratio()

func save_screen_ratio() -> void:
	var config = ConfigFile.new()
	config.set_value("display", "screen_ratio", screen_ratio)
	config.save("user://settings.cfg")
	apply_screen_ratio()

func get_camera_width() -> float:
	if screen_ratio == 0.0:
		return 426.0

	return 240.0 * screen_ratio

func apply_screen_ratio() -> void:
	var window = get_tree().root

	window.content_scale_size = Vector2i(
		roundi(get_camera_width()),
		240
	)

	if screen_ratio == 0.0:
		window.content_scale_aspect = Window.CONTENT_SCALE_ASPECT_EXPAND
	else:
		window.content_scale_aspect = Window.CONTENT_SCALE_ASPECT_KEEP
