extends Node

signal health_changed

var health: int = 48:
	set(value):
		health = value
		health_changed.emit()

var player = null

var player_start_position = null

var current_checkpoint = null

func respawn_player():
	if current_checkpoint != null:
		player.position = current_checkpoint.global_position
	else:
		player.global_position = player_start_position.global_position
