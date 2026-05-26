extends Node

signal health_changed

var mangos:= 0 

var score:= 0

var health:= 6

var player = null

var player_start_position = null

var current_checkpoint = null

var last_home : String = ""

func respawn_player():
	if current_checkpoint != null:
		player.position = current_checkpoint.global_position
	else:
		player.global_position = player_start_position.global_position
	print("respawnou")
