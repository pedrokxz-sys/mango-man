extends Node2D

var last_home_position

@onready var player := $player as CharacterBody2D
@onready var player_scene = preload("res://actors/player.tscn")
@onready var camera := $Camera2D as Camera2D
@onready var hunter_door_position: Marker2D = $hunter_door/hunter_door_position
@onready var animator: AnimationPlayer = $goal/animator
@onready var player_start_position: Marker2D = $player_start_position

func _ready() -> void:
	animator.play("start")
	Globals.player_start_position = player_start_position
	Globals.player = player
	Globals.player.follow_camera(camera)
	Globals.player.player_has_died.connect(reload_game)
	_what_is_the_last_home()
	if Globals.last_home != "":
		Globals.player.global_position = last_home_position

func reload_game():
	await get_tree().create_timer(1.0).timeout
	
	if is_instance_valid(Globals.player):
		Globals.player.queue_free()
	
	var _player = player_scene.instantiate()
	add_child(_player)
	move_child(_player, 5)
	
	Globals.player = _player
	Globals.player.follow_camera(camera)
	Globals.player.player_has_died.connect(reload_game)
	
	Globals.health = 6
	Globals.respawn_player()

func _what_is_the_last_home():
	if Globals.last_home == "hunter_home":
		last_home_position = hunter_door_position.global_position
