extends Node2D

const DIALOG_SCREEN = preload("res://prefabs/dialog_screen.tscn")
var first_dialog: Dictionary =  {
	0:{
		"_name": "Bóris",
		"_dialog": "A casa do prefeito fica à direita!",
		"_faceset": "res://assets/people/hunter/hunter_faceset.png"
	}
}
var second_dialog:Dictionary = { 
	0:{
		"_name": "Bóris",
		"_dialog": "Ali está ele!",
		"_faceset": "res://assets/people/hunter/hunter_faceset.png"
	},
	1:{
		"_name": "Bóris",
		"_dialog": "Bom-dia, Seu Chico!",
		"_faceset": "res://assets/people/hunter/hunter_faceset.png"
	},
	2:{
		"_name": "Chico",
		"_dialog": "Bom-dia, Bóris!",
		"_faceset": "res://assets/people/mayor/mayor_faceset.png"
	},
	3:{
		"_name": "Chico",
		"_dialog": "Bom-dia pra você também, Murillo!",
		"_faceset": "res://assets/people/mayor/mayor_faceset.png"
	},
	4:{
		"_name": "Murillo",
		"_dialog": "Bom-dia, Seu Chico!",
		"_faceset": "res://assets/player/player_faceset.png"
	},
	5:{
		"_name": "Chico",
		"_dialog": "O que traz vocês aqui?",
		"_faceset": "res://assets/people/mayor/mayor_faceset.png"
	},
	6:{
		"_name": "Murillo",
		"_dialog": "Temos um assunto sério para falar com o senhor.",
		"_faceset": "res://assets/player/player_faceset.png"
	},
	7:{
		"_name": "Chico",
		"_dialog": "Sendo assim, entrem na minha casa para conversarmos.",
		"_faceset": "res://assets/people/mayor/mayor_faceset.png"
	}
}
var third_dialog:Dictionary = {
	0:{
		"_name": "Murillo",
		"_dialog": "Quem está ai!?",
		"_faceset": "res://assets/player/player_faceset.png"
	},
	1:{
		"_name": "Hanna",
		"_dialog": "SOCORRO! ALGUÉM ME AJUDA!",
		"_faceset": "res://assets/people/confectioner/confectioner_faceset.png"
	},
	2:{
		"_name": "Chico",
		"_dialog": "Hanna! O que está acontecendo?!",
		"_faceset": "res://assets/people/mayor/mayor_faceset.png"
	},
	3:{
		"_name": "Hanna",
		"_dialog": "Tem um macaco roubando minha loja!",
		"_faceset": "res://assets/people/confectioner/confectioner_faceset.png"
	},
	4:{
		"_name": "Bóris",
		"_dialog": "Um macaco?!",
		"_faceset": "res://assets/people/hunter/hunter_faceset.png"
	},
	5:{
		"_name": "Murillo",
		"_dialog": "Deixa que eu pego ele!",
		"_faceset": "res://assets/player/player_faceset.png"
	},
}
var fourth_dialog:Dictionary = {
	0:{
		"_name": "Bóris",
		"_dialog": "Vish! O macaco está alto de mais!",
		"_faceset": "res://assets/people/hunter/hunter_faceset.png"
	},
	1:{
		"_name": "Murillo",
		"_dialog": "É verdade! Nâo consigo alcançar.",
		"_faceset": "res://assets/player/player_faceset.png"
	},
	2:{
		"_name": "Bóris",
		"_dialog": "Espera ai, vem cá Murillo!",
		"_faceset": "res://assets/people/hunter/hunter_faceset.png"
	},
}
var fifth_dialog:Dictionary = {
	0:{
		"_name": "Bóris",
		"_dialog": "Isso ainda é só um projeto, mas experimente!",
		"_faceset": "res://assets/people/hunter/hunter_faceset.png"
	},
	1:{
		"_name": "Murillo",
		"_dialog": "O que é isso!?",
		"_faceset": "res://assets/player/player_faceset.png"
	},
	2:{
		"_name": "Bóris",
		"_dialog": "Isso é um lançador de rede para animais.",
		"_faceset": "res://assets/people/hunter/hunter_faceset.png"
	},
}
var sixth_dialog:Dictionary = {
	0:{
		"_name": "Bóris",
		"_dialog": "Vai pegar o macaco em cima da casa!",
		"_faceset": "res://assets/people/hunter/hunter_faceset.png"
	},
	1:{
		"_name": "Murillo",
		"_dialog": "Tá certo!",
		"_faceset": "res://assets/player/player_faceset.png"
	},
}
var new_dialog
var _01_dialog_finished
var _02_dialog_finished
var last_home_position

@onready var player := $player as CharacterBody2D
@onready var player_scene = preload("res://actors/player.tscn")
@onready var camera := $Camera2D as Camera2D
@onready var hunter_door_position: Marker2D = $hunter_door/hunter_door_position
@onready var mayor_door_position: Marker2D = $mayor_door/mayor_door_position
@onready var player_start_position: Marker2D = $player_start_position
@onready var hud: CanvasLayer = $HUD
@onready var texture: Sprite2D = $hunter/speech_area/texture
@onready var hunter: CharacterBody2D = $hunter
@onready var mayor: CharacterBody2D = $mayor
@onready var confectioner: CharacterBody2D = $confectioner

func _ready() -> void:
	$tutorial_screen.first_tutorial = false
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

	if !Cutscenes._01_mayor_finished:
		if player.global_position.x >= 1050 and !Globals.dialog_is_on:
			_play_dialog()
	if !Cutscenes._01_mayor_finished and Cutscenes._01_town_finished and new_dialog == null:
		Globals.dialog_is_on = true
		if !$mayor_door/animator.is_animation_active():
			$mayor_door/animator.play("goal")
	if !Cutscenes._03_town_finished and player.velocity.y != 0 and Input.is_action_just_pressed("ui_collect"):
		await get_tree().create_timer(0.5).timeout
		_play_dialog()
		await get_tree().create_timer(.5).timeout
		Cutscenes._03_town_finished = true
	if Cutscenes._03_town_finished and player.global_position.x < 1265 and !_02_dialog_finished:
		_play_dialog()
		await get_tree().create_timer(0.5).timeout
		_02_dialog_finished = true
	if _02_dialog_finished and new_dialog == null:
		Globals.can_use_long_collect = true

	if Cutscenes._02_town_finished and !Cutscenes._03_town_finished and new_dialog == null and player.global_position.x <= 1250:
		_play_dialog()


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
	if Globals.last_home == "mayor_home":
		last_home_position = mayor_door_position.global_position

func _play_dialog():
	if Cutscenes._01_animal_room_finished and !Cutscenes._01_town_finished and !Cutscenes._01_mayor_finised:
		if !_01_dialog_finished:
			hunter.global_position = Vector2(381, 129)
			$barrier/anim.play("pass")
			$barrier/collsion.disabled = true
			_01_dialog_finished = true
			$hunter_door.global_position.y += 100
			$hunter/speech_area.visible = false
			new_dialog =  DIALOG_SCREEN.instantiate()
			new_dialog.data = first_dialog
			hud.add_child(new_dialog)
	if !Cutscenes._01_town_finished and !Cutscenes._01_mayor_finished:
		if player.global_position.x >= 1050:
			Cutscenes._01_town_finished = true
			Globals.dialog_direction = 1
			new_dialog =  DIALOG_SCREEN.instantiate()
			new_dialog.data = second_dialog
			hud.add_child(new_dialog)
			if new_dialog.id != 2:
				await get_tree().create_timer(1).timeout
				$mayor/texture.scale.x = 1
	if Cutscenes._01_mayor_finished and !Cutscenes._02_town_finished:
		$box.play("broken")
		Cutscenes._02_town_finished = true
		Globals.player.global_position = Vector2(1276, 165)
		hunter.global_position = Vector2(1230, 177)
		hunter.scale.x = -1
		mayor.global_position = Vector2(1252, 177)
		confectioner.global_position = Vector2(1356, 177)
		$mayor_door.global_position.y += 100
		Globals.dialog_direction = 1
		new_dialog =  DIALOG_SCREEN.instantiate()
		new_dialog.data = third_dialog
		hud.add_child(new_dialog)
		Globals.can_attack = true
		Globals.is_run = true
	if Cutscenes._02_town_finished and !Cutscenes._03_town_finished and new_dialog == null and player.global_position.x <= 1250:
		Globals.dialog_direction = -1
		new_dialog =  DIALOG_SCREEN.instantiate()
		new_dialog.data = sixth_dialog
		hud.add_child(new_dialog)
		player.global_position.x += 8
		Cutscenes._03_town_finished = false
	if Cutscenes._02_town_finished and !Cutscenes._03_town_finished and new_dialog == null:
		Globals.dialog_direction = -1
		new_dialog =  DIALOG_SCREEN.instantiate()
		new_dialog.data = fourth_dialog
		hud.add_child(new_dialog)
		Cutscenes._03_town_finished = true
	if Cutscenes._03_town_finished == true and !_02_dialog_finished and new_dialog == null:
		Globals.dialog_direction = -1
		new_dialog =  DIALOG_SCREEN.instantiate()
		new_dialog.data = fifth_dialog
		hud.add_child(new_dialog)
		Globals.can_attack = true
		Globals.is_run = true
