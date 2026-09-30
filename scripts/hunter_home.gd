extends Node2D

const DIALOG_SCREEN = preload("res://prefabs/dialog_screen.tscn")
var first_dialog: Dictionary = {
	0: {
		"_name": "Caçador",
		"_dialog": "Ora se não é você, Murillo, o nosso fazendeiro de mangas.",
		"_faceset": "res://assets/people/hunter/hunter_faceset.png"
	}, 
	1: {
		"_name": "Fazendeiro",
		"_dialog": "E aí Bóris, tenho algo pra te mostrar.",
		"_faceset": "res://assets/player/player_faceset.png"
	}, 
	2: {
		"_name": "Caçador",
		"_dialog": "O que te traz aqui?",
		"_faceset": "res://assets/people/hunter/hunter_faceset.png"
	}, 
	3: {
		"_name": "Caçador",
		"_dialog": "EITA!",
		"_faceset": "res://assets/people/hunter/hunter_faceset.png"
	}, 
	4: {
		"_name": "Caçador",
		"_dialog": "Onde vc encontrou tantos animais!?",
		"_faceset": "res://assets/people/hunter/hunter_faceset.png"
	},
	5: {
		"_name": "Fazendeiro",
		"_dialog": "Esses animais estavam na florestra perto da minha fazenda.",
		"_faceset": "res://assets/player/player_faceset.png"
	}, 
	6: {
		"_name": "Caçador",
		"_dialog": "Como esses animais foram parar as bordas das sua fazenda?",
		"_faceset": "res://assets/people/hunter/hunter_faceset.png"
	}, 
	7: {
		"_name": "Fazendeiro",
		"_dialog": "Eu realmente não sei.",
		"_faceset": "res://assets/player/player_faceset.png"
	}, 
	8: {
		"_name": "Caçador",
		"_dialog": "Vamos achar um lugar para eles.",
		"_faceset": "res://assets/people/hunter/hunter_faceset.png"
	}
}

var new_dialog = null
var player_is_close = false
var last_dialog:String = ""

@onready var player := $player as CharacterBody2D
@onready var player_scene = preload("res://actors/player.tscn")
@onready var player_start_position: Marker2D = $player_start_position
@onready var animator: AnimationPlayer = $door/animator
@onready var hud: CanvasLayer = $HUD
@onready var texture: Sprite2D = $hunter/speech_area/texture

func _ready() -> void:
	animator.play("start")
	Globals.player_start_position = player_start_position
	Globals.player = player
	Globals.player.player_has_died.connect(reload_game)
	Globals.can_use_long_collect = true

	texture.visible = false

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_crouch"):
		if new_dialog == null and player_is_close:
			new_dialog =  DIALOG_SCREEN.instantiate()
			new_dialog.data = first_dialog
			hud.add_child(new_dialog)
	if new_dialog != null:
		texture.visible = false
		Globals.dialog_is_on = true
	else:
		Globals.dialog_is_on = false

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


func _on_speech_area_body_entered(body: Node2D) -> void:
	if body.name == "player":
		texture.visible = true
		player_is_close = true

func _on_speech_area_body_exited(body: Node2D) -> void:
	if body.name == "player":
		texture.visible = false
		player_is_close = false

func _what_is_dialog():
	pass
