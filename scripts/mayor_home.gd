extends Node2D

const DIALOG_SCREEN = preload("res://prefabs/dialog_screen.tscn")
var first_dialog: Dictionary = {
	0: {
		"_name": "Prefeito",
		"_dialog": "Então, de que assunto vamos tratar?",
		"_faceset": "res://assets/people/mayor/mayor_faceset.png"
	}, 
	1: {
		"_name": "Caçador",
		"_dialog": "Tasta-se de um assuto com animais de espécies invasoras nas proximidades.",
		"_faceset": "res://assets/people/hunter/hunter_faceset.png"
	},
	2: {
		"_name": "Prefeito",
		"_dialog": "Como assim animais invasores!?",
		"_faceset": "res://assets/people/mayor/mayor_faceset.png"
	},
	3: {
		"_name": "Caçador",
		"_dialog": "Coelhos, ouriços e esquilos.",
		"_faceset": "res://assets/people/hunter/hunter_faceset.png"
	},
	4: {
		"_name": "Prefeito",
		"_dialog": "Não tem como.",
		"_faceset": "res://assets/people/mayor/mayor_faceset.png"
	},
	5: {
		"_name": "Caçador",
		"_dialog": "Sendo assim, como Murillo achou esses animais?",
		"_faceset": "res://assets/people/hunter/hunter_faceset.png"
	},
	6: {
		"_name": "Fazendeiro",
		"_dialog": "É verdade, pode confiar em mim e se quiser pode ir vê-los.",
		"_faceset": "res://assets/player/player_faceset.png"
	}, 
	7: {
		"_name": "Prefeito",
		"_dialog": "E onde eles estão agora?",
		"_faceset": "res://assets/people/mayor/mayor_faceset.png"
	},
	8: {
		"_name": "Fazendeiro",
		"_dialog": "Eles esstão seguros na casa de Bóris.",
		"_faceset": "res://assets/player/player_faceset.png"
	}, 
	9: {
		"_name": "Prefeito",
		"_dialog": "Está certo eu acredito em vocês.",
		"_faceset": "res://assets/people/mayor/mayor_faceset.png"
	},
	10: {
		"_name": "Prefeito",
		"_dialog": "Agora, eu acho que não podemos deixa-los lá por muito tempo.",
		"_faceset": "res://assets/people/mayor/mayor_faceset.png"
	},
	11: {
		"_name": "Caçador",
		"_dialog": "Está certo, por isso viemos falar com o senhor.",
		"_faceset": "res://assets/people/hunter/hunter_faceset.png"
	},
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
@warning_ignore("unused_private_class_variable")
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
	Globals.can_attack = false
	Globals.is_run = false
	animator.play("start")
	Globals.player_start_position = player_start_position
	Globals.player = player
	Globals.player.player_has_died.connect(reload_game)

	_play_dialog()

func _physics_process(_delta: float) -> void:
	if new_dialog != null:
		texture.visible = false
		Globals.dialog_is_on = true
	else:
		Globals.dialog_is_on = false

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

func _play_dialog():
	if !_01_dialog_start:
		Globals.dialog_direction = -1
		new_dialog =  DIALOG_SCREEN.instantiate()
		new_dialog.data = first_dialog
		hud.add_child(new_dialog)
