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
	12: {
		"_name": "Prefeito",
		"_dialog": "Bem, o correto a se fazer é devolver esses animais para seus habitats naturais.",
		"_faceset": "res://assets/people/mayor/mayor_faceset.png"
	},
	13: {
		"_name": "Prefeito",
		"_dialog": "Agora, não podemos deixa-los em qualquer lugar.",
		"_faceset": "res://assets/people/mayor/mayor_faceset.png"
	},
	14: {
		"_name": "Prefeito",
		"_dialog": "Então vamos olhar o mapa da região local.",
		"_faceset": "res://assets/people/mayor/mayor_faceset.png"
	},
	15: {
		"_name": "Prefeito",
		"_dialog": "O mapa está aqui.",
		"_faceset": "res://assets/people/mayor/mayor_faceset.png"
	},
}
var second_dialog: Dictionary =  {
	0: {
		"_name": "Prefeito",
		"_dialog": "Esse é o mapa da Ilha da Manga.",
		"_faceset": "res://assets/people/mayor/mayor_faceset.png"
	},
	1: {
		"_name": "Fazendeiro",
		"_dialog": "Bem aqui está a minha fazenda.",
		"_faceset": "res://assets/player/player_faceset.png"
	},
	2:{
		"_name": "Prefeito",
		"_dialog": "Exato, e nós estamos aqui na cidade Pinheiro.",
		"_faceset": "res://assets/people/mayor/mayor_faceset.png"
	},
	3: {
		"_name": "Caçador",
		"_dialog": "Bom, então onde deixaremos os animais?",
		"_faceset": "res://assets/people/hunter/hunter_faceset.png"
	},
	4:{
		"_name": "Prefeito",
		"_dialog": "Esses animais são de espécies invasoras da região.",
		"_faceset": "res://assets/people/mayor/mayor_faceset.png"
	},
	5:{
		"_name": "Prefeito",
		"_dialog": "Logo não podemos só deixar eles nas florestas ao redor.",
		"_faceset": "res://assets/people/mayor/mayor_faceset.png"
	},
	6: {
		"_name": "Caçador",
		"_dialog": "Verdade, isso ira gerar um risco para as espécies invasoras e também para as espécies locais.",
		"_faceset": "res://assets/people/hunter/hunter_faceset.png"
	},
	7: {
		"_name": "Fazendeiro",
		"_dialog": "E no que isso nos afeta?",
		"_faceset": "res://assets/player/player_faceset.png"
	},
	8: {
		"_name": "Caçador",
		"_dialog": "Ocorre um desequilibrio na cadeia alimentar e posteriormente nos sofremos de forma indireta.",
		"_faceset": "res://assets/people/hunter/hunter_faceset.png"
	},
	9: {
		"_name": "Caçador",
		"_dialog": "Como o ocorrido na sua fazenda, onde animais roubavam mais para sobreviver.",
		"_faceset": "res://assets/people/hunter/hunter_faceset.png"
	},
	10: {
		"_name": "Fazendeiro",
		"_dialog": "Entendi, mas então onde vamos deixa-los?",
		"_faceset": "res://assets/player/player_faceset.png"
	},
	11:{
		"_name": "Prefeito",
		"_dialog": "Eu estava me lembrando enquanto vocês falavam.",
		"_faceset": "res://assets/people/mayor/mayor_faceset.png"
	},
	12:{
		"_name": "Prefeito",
		"_dialog": "Existe um recente projeto de unidade de conservação na Península da Folha.",
		"_faceset": "res://assets/people/mayor/mayor_faceset.png"
	},
	13: {
		"_name": "Fazendeiro",
		"_dialog": "Onde fica essa Penísula da Folha?",
		"_faceset": "res://assets/player/player_faceset.png"
	},
	14:{
		"_name": "Prefeito",
		"_dialog": "É nessa parte da ilha que parece a folha da manga, parece não ter nada, porque o mapa é antigo.",
		"_faceset": "res://assets/people/mayor/mayor_faceset.png"
	},
	15: {
		"_name": "Caçador",
		"_dialog": "É exatamente o que estavamos procurando.",
		"_faceset": "res://assets/people/hunter/hunter_faceset.png"
	},
	16: {
		"_name": "Fazendeiro",
		"_dialog": "Então vamos deixar eles lá?",
		"_faceset": "res://assets/player/player_faceset.png"
	},
	17:{
		"_name": "Prefeito",
		"_dialog": "Ainda não. Precisamos entrar em contato e verificar se eles podem receber essas espécies.",
		"_faceset": "res://assets/people/mayor/mayor_faceset.png"
	},
	18:{
		"_name": "Prefeito",
		"_dialog": "Vou ver se encontro o número de algum responsável na minha agenda.",
		"_faceset": "res://assets/people/mayor/mayor_faceset.png"
	},
}
var third_dialog: Dictionary =  {
	0: {
		"_name": "Caçador",
		"_dialog": "Que barulho é esse!?",
		"_faceset": "res://assets/people/hunter/hunter_faceset.png"
	},
	1: {
		"_name": "Prefeito",
		"_dialog": "Veio lá de fora!",
		"_faceset": "res://assets/people/mayor/mayor_faceset.png"
	},
	2: {
		"_name": "Desconhecido",
		"_dialog": "AAA NÃO!!!",
		"_faceset": "res://assets/tonw/unknown_faceset.png"
	}, 
	3: {
		"_name": "Desconhecido",
		"_dialog": "SAI, SAI, SAI!!!",
		"_faceset": "res://assets/tonw/unknown_faceset.png"
	}, 
	4: {
		"_name": "Fazendeiro",
		"_dialog": "Tem alguém em perigo!",
		"_faceset": "res://assets/player/player_faceset.png"
	},
	5: {
		"_name": "Fazendeiro",
		"_dialog": "Vamos lá ajudar!",
		"_faceset": "res://assets/player/player_faceset.png"
	},
}

var new_dialog = null
var player_is_close = false

var _01_dialog_start 
var _02_dialog_start 
var _03_dialog_start 

@onready var player := $player as CharacterBody2D
@onready var player_scene = preload("res://actors/player.tscn")
@onready var player_start_position: Marker2D = $player_start_position
@onready var camera := $Camera2D as Camera2D
@onready var animator: AnimationPlayer = $door/animator
@onready var hud: CanvasLayer = $HUD
@onready var texture: Sprite2D = $hunter/speech_area/texture
@onready var scene_anim: AnimationPlayer = $scene_anim
@onready var circle: Sprite2D = $circle

func _ready() -> void:
	Globals.can_attack = false
	Globals.is_run = false
	Globals.last_home = "mayor_home"
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

	if _01_dialog_start and !_02_dialog_start and new_dialog == null:
		_play_dialog()
	if _02_dialog_start and !_03_dialog_start and new_dialog == null:
		_play_dialog()
	if new_dialog != null and new_dialog.data == second_dialog:
		if new_dialog.id == 1:
			circle.visible = true
			circle.global_position = Vector2(127, 66)
		if new_dialog.id == 2:
			circle.global_position = Vector2(159, 61)
		if new_dialog.id == 3:
			circle.visible = false
		if new_dialog.id == 14:
			circle.visible = true
			circle.global_position = Vector2(194, 52)
		if new_dialog.id == 15:
			$map.visible = false
			if !$map/audio.playing and circle.visible == true:
				$map/audio.play()
			circle.visible = false 

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
	if Cutscenes._01_mayor_finised == false:
		if !_01_dialog_start:
			_01_dialog_start = true
			Globals.dialog_direction = -1
			new_dialog =  DIALOG_SCREEN.instantiate()
			new_dialog.data = first_dialog
			hud.add_child(new_dialog)
		if _01_dialog_start and !_02_dialog_start and new_dialog == null:
			_02_dialog_start = true
			$map.visible = true
			$map/audio.play()
			new_dialog =  DIALOG_SCREEN.instantiate()
			new_dialog.data = second_dialog
			await  get_tree().create_timer(1).timeout
			Globals.dialog_direction = -1
			hud.add_child(new_dialog)
		if _02_dialog_start and !_03_dialog_start and new_dialog == null:
			_03_dialog_start = true
			$audio_unknown.play()
			Globals.dialog_direction = 1
			$hunter/texture.scale.x = -1
			new_dialog =  DIALOG_SCREEN.instantiate()
			new_dialog.data = third_dialog
			await  get_tree().create_timer(1).timeout
			hud.add_child(new_dialog)
			Cutscenes._01_mayor_finised = true
