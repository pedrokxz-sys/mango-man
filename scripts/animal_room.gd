extends Node2D

const DIALOG_SCREEN = preload("res://prefabs/dialog_screen.tscn")
var first_dialog: Dictionary = {
	0: {
		"_name": "Caçador",
		"_dialog": "Aqui é meu quarto dos fundos!",
		"_faceset": "res://assets/people/hunter/hunter_faceset.png"
	}, 
	1: {
		"_name": "Caçador",
		"_dialog": "Nesse lugar eu tenho gaiolas pra guardar esses animais.",
		"_faceset": "res://assets/people/hunter/hunter_faceset.png"
	}
}
var second_dialog: Dictionary =  {
	0: {
		"_name": "Caçador",
		"_dialog": "Pronto, agr as gaiolas estão todas cheias com animais!",
		"_faceset": "res://assets/people/hunter/hunter_faceset.png"
	},
	1: {
		"_name": "Caçador",
		"_dialog": "Vamos sair e procurar falar com o prefeito.",
		"_faceset": "res://assets/people/hunter/hunter_faceset.png"
	}
}

var new_dialog = null
var player_is_close = false

var _01_dialog_start 
var _02_dialog_start 

@onready var player := $player as CharacterBody2D
@onready var player_scene = preload("res://actors/player.tscn")
@onready var player_start_position: Marker2D = $player_start_position
@onready var camera := $Camera2D as Camera2D
@onready var animator: AnimationPlayer = $door/animator
@onready var hud: CanvasLayer = $HUD
@onready var texture: Sprite2D = $hunter/speech_area/texture
@onready var scene_anim: AnimationPlayer = $scene_anim

func _ready() -> void:
	_play_dialog()
	animator.play("start")
	Globals.player_start_position = player_start_position
	Globals.player = player
	Globals.player.player_has_died.connect(reload_game)
	Globals.can_use_long_collect = true

	texture.visible = false

func _physics_process(_delta: float) -> void:
	if new_dialog != null:
		texture.visible = false
		Globals.dialog_is_on = true
	else:
		Globals.dialog_is_on = false

	if _01_dialog_start and !_02_dialog_start:
		if new_dialog == null:
			scene_anim.play("pulse")
			Globals.score = 0

	if !Cutscenes._01_animal_room_finished:
		Globals.dialog_is_on = true

	if Input.is_action_just_pressed("ui_crouch"):
		if new_dialog == null and player_is_close:
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

func _on_speech_area_body_entered(body: Node2D) -> void:
	if body.name == "player":
		texture.visible = true
		player_is_close = true

func _on_speech_area_body_exited(body: Node2D) -> void:
	if body.name == "player":
		texture.visible = false
		player_is_close = false

func _on_scene_anim_animation_finished(anim_name: StringName) -> void:
	if anim_name == "pulse":
			_play_dialog()
			_02_dialog_start = true 
			$eyes.play("blinking")

func _play_dialog():
	if _01_dialog_start:
		new_dialog =  DIALOG_SCREEN.instantiate()
		new_dialog.data = second_dialog
		hud.add_child(new_dialog)
		await get_tree().create_timer(3).timeout
		Cutscenes._01_animal_room_finished = true
	else:
		new_dialog =  DIALOG_SCREEN.instantiate()
		new_dialog.data = first_dialog
		hud.add_child(new_dialog)
		_01_dialog_start = true
