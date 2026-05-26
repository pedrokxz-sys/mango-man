extends Node2D

@onready var player := $player as CharacterBody2D
@onready var player_scene = preload("res://actors/player.tscn")
@onready var player_start_position: Marker2D = $player_start_position
@onready var animator: AnimationPlayer = $door/animator

func _ready() -> void:
	animator.play("start")
	Globals.player_start_position = player_start_position
	Globals.player = player
	Globals.player.player_has_died.connect(reload_game)

func reload_game():
	await get_tree().create_timer(1.0).timeout
	
	if is_instance_valid(Globals.player):
		Globals.player.queue_free()
	
	var player = player_scene.instantiate()
	add_child(player)
	move_child(player, 5)
	
	Globals.player = player
	Globals.player.player_has_died.connect(reload_game)
	Globals.health = 6
	Globals.respawn_player()
