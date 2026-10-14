extends Node2D

const DIALOG_SCREEN = preload("res://prefabs/dialog_screen.tscn")
var first_dialog: Dictionary =  {
	0:{
		"_name": "Caçador",
		"_dialog": "A casa do prefeito fica à direita!",
		"_faceset": "res://assets/people/hunter/hunter_faceset.png"
	}
}

var new_dialog
var last_home_position

@onready var player := $player as CharacterBody2D
@onready var player_scene = preload("res://actors/player.tscn")
@onready var camera := $Camera2D as Camera2D
@onready var hunter_door_position: Marker2D = $hunter_door/hunter_door_position
@onready var animator: AnimationPlayer = $goal/animator
@onready var player_start_position: Marker2D = $player_start_position
@onready var hud: CanvasLayer = $HUD
@onready var texture: Sprite2D = $hunter/speech_area/texture
@onready var hunter: CharacterBody2D = $hunter

func _ready() -> void:
	animator.play("start")
	Globals.player_start_position = player_start_position
	Globals.player = player
	Globals.player.follow_camera(camera)
	Globals.player.player_has_died.connect(reload_game)
	_what_is_the_last_home()
	_play_dialog()
	if Globals.last_home != "":
		Globals.player.global_position = last_home_position

func _physics_process(_delta: float) -> void:
	if new_dialog != null:
		texture.visible = false
		Globals.dialog_is_on = true
	else:
		Globals.dialog_is_on = false

	if !Cutscenes._01_town_finished:
		_hunter_with_player()


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
	hunter.global_position = Vector2(600, 100)
	if Cutscenes._01_animal_room_finished:
		$hunter.global_position = Vector2(381, 129)
		$barrier/anim.play("pass")
		$barrier/collsion.disabled = true
		new_dialog =  DIALOG_SCREEN.instantiate()
		new_dialog.data = first_dialog
		hud.add_child(new_dialog)
		if !Cutscenes._01_town_finished:
			$hunter_door.global_position = Vector2(0, -100)

func _hunter_with_player():
	if player.velocity.x > 0 and !$hunter/wall_detector.is_colliding():
		hunter.global_position.x = player.global_position.x - 16
	if player.velocity.x < 0 and !$hunter/wall_detector.is_colliding():
		hunter.global_position.x = player.global_position.x - -16
