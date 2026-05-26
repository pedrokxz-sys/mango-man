extends Node2D

@onready var player := $player as CharacterBody2D
@onready var player_scene = preload("res://actors/player.tscn")
@onready var camera := $Camera2D as Camera2D
@onready var hunter_door: Marker2D = $door/hunter_door
@onready var animator: AnimationPlayer = $goal/animator
@onready var player_start_position: Marker2D = $player_start_position

func _ready() -> void:
	animator.play("start")
	Globals.player_start_position = player_start_position
	Globals.player = player
	Globals.player.follow_camera(camera)
	Globals.player.player_has_died.connect(reload_game)
	$door.player_exit_hunter.connect(exit_hunter)
	if Globals.last_home == "hunter":
		Globals.player.global_position = hunter_door.global_position

func reload_game():
	await get_tree().create_timer(1.0).timeout
	
	if is_instance_valid(Globals.player):
		Globals.player.queue_free()
	
	var player = player_scene.instantiate()
	add_child(player)
	move_child(player, 5)
	
	Globals.player = player
	Globals.player.follow_camera(camera)
	Globals.player.player_has_died.connect(reload_game)
	
	Globals.health = 6
	Globals.respawn_player()
	
func exit_hunter():
	Globals.last_home = "hunter"
	print(Globals.last_home)
