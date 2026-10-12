extends Node2D

const  LEVEL_ID:= "res://levels/world_01.tscn"

@onready var player := $player as CharacterBody2D
@onready var player_scene = preload("res://actors/player.tscn")
@onready var camera := $Camera2D as Camera2D
@onready var player_start_position: Marker2D = $prefabs/checkpoints/player_start_position
@onready var animator: AnimationPlayer = $goal/animator

var pass_one_seg = true

func _ready() -> void:
	animator.play("start")
	Globals.health = 6
	Globals.player_start_position = player_start_position
	Globals.player = player
	Globals.player.follow_camera(camera)
	Globals.player.player_has_died.connect(reload_game)

func _physics_process(_delta: float) -> void:
	if Globals.seg <= -1:
		Globals.min -= 1
		Globals.seg = 59
	if pass_one_seg:
		pass_one_seg = false
		await get_tree().create_timer(1).timeout
		Globals.seg -= 1
		pass_one_seg = true
	if Globals.min < 0:
		get_tree().change_scene_to_file(LEVEL_ID)

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
