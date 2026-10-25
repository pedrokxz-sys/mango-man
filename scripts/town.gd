extends Node2D

const DIALOG_SCREEN = preload("res://prefabs/dialog_screen.tscn")
var first_dialog: Dictionary =  {
	0:{
		"_name": "Caçador",
		"_dialog": "A casa do prefeito fica à direita!",
		"_faceset": "res://assets/people/hunter/hunter_faceset.png"
	}
}
var second_dialog:Dictionary = { 
	0:{
		"_name": "Caçador",
		"_dialog": "Ali está ele!",
		"_faceset": "res://assets/people/hunter/hunter_faceset.png"
	},
	1:{
		"_name": "Caçador",
		"_dialog": "Bom-dia, Seu Chico!",
		"_faceset": "res://assets/people/hunter/hunter_faceset.png"
	},
	2:{
		"_name": "Prefeito",
		"_dialog": "Bom-dia, Bóris!",
		"_faceset": "res://assets/people/mayor/mayor_faceset.png"
	},
	3:{
		"_name": "Prefeito",
		"_dialog": "Bom-dia pra você também, Murillo!",
		"_faceset": "res://assets/people/mayor/mayor_faceset.png"
	},
	4:{
		"_name": "Fazendeiro",
		"_dialog": "Bom-dia, Seu Chico!",
		"_faceset": "res://assets/player/player_faceset.png"
	},
	5:{
		"_name": "Prefeito",
		"_dialog": "O que traz vocês aqui?",
		"_faceset": "res://assets/people/mayor/mayor_faceset.png"
	},
	6:{
		"_name": "Fazendeiro",
		"_dialog": "Temos um assunto sobre um massa de animais invasores para tratar com o senhor.",
		"_faceset": "res://assets/player/player_faceset.png"
	},
	7:{
		"_name": "Prefeito",
		"_dialog": "Sendo assim, entrem na minha casa para conversarmos.",
		"_faceset": "res://assets/people/mayor/mayor_faceset.png"
	}
}

var new_dialog
var _01_dialog_finished
var last_home_position

@onready var player := $player as CharacterBody2D
@onready var player_scene = preload("res://actors/player.tscn")
@onready var camera := $Camera2D as Camera2D
@onready var hunter_door_position: Marker2D = $hunter_door/hunter_door_position
@onready var player_start_position: Marker2D = $player_start_position
@onready var hud: CanvasLayer = $HUD
@onready var texture: Sprite2D = $hunter/speech_area/texture
@onready var hunter: CharacterBody2D = $hunter

func _ready() -> void:
	Cutscenes._01_animal_room_finished = true
	Globals.is_run = false
	Globals.can_attack = false
	$goal/animator.play("start")
	Globals.player_start_position = player_start_position
	Globals.player = player
	Globals.player.follow_camera(camera)
	Globals.player.player_has_died.connect(reload_game)
	_what_is_the_last_home()
	if Globals.last_home != "":
		Globals.player.global_position = last_home_position
	_play_dialog()

func _physics_process(_delta: float) -> void:
	if new_dialog != null:
		texture.visible = false
		Globals.dialog_is_on = true
	else:
		Globals.dialog_is_on = false

	if player.global_position.x >= 1050 and !Globals.dialog_is_on:
		_play_dialog()
	if Cutscenes._01_town_finished and new_dialog == null:
		Globals.dialog_is_on = true
		if !$mayor_door/animator.is_animation_active():
			$mayor_door/animator.play("goal")


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

func _play_dialog():
	if Cutscenes._01_animal_room_finished and !Cutscenes._01_town_finished:
		if !_01_dialog_finished:
			hunter.global_position = Vector2(381, 129)
			$barrier/anim.play("pass")
			$barrier/collsion.disabled = true
			_01_dialog_finished = true
			$hunter_door.global_position = Vector2(0, -100)
			$hunter/speech_area.visible = false
			new_dialog =  DIALOG_SCREEN.instantiate()
			new_dialog.data = first_dialog
			hud.add_child(new_dialog)
	if !Cutscenes._01_town_finished:
		if player.global_position.x >= 1050:
			Globals.dialog_direction = 1
			new_dialog =  DIALOG_SCREEN.instantiate()
			new_dialog.data = second_dialog
			hud.add_child(new_dialog)
			while new_dialog.id != 2:
				await get_tree().create_timer(1).timeout
			$mayor/texture.scale.x = 1
			await get_tree().create_timer(1).timeout
			Cutscenes._01_town_finished = true
