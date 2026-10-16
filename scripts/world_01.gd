extends Node2D

const  LEVEL_ID:= "res://levels/world_01.tscn"

@onready var player := $player as CharacterBody2D
@onready var player_scene = preload("res://actors/player.tscn")
@onready var camera := $Camera2D as Camera2D
@onready var player_start_position: Marker2D = $prefabs/checkpoints/player_start_position
@onready var animator: AnimationPlayer = $goal/animator
@onready var label: RichTextLabel = $msg_screen/control/HBoxContainer/VBoxContainer/label
@onready var back: ColorRect = $msg_screen/control/back

var pass_one_seg = true

func _ready() -> void:
	Globals.is_run = true
	animator.play("start")

	Globals.min = 5
	Globals.seg = 0
	Globals.health = 6
	Globals.score = 0
	Globals.mangos = 0

	Globals.player_start_position = player_start_position
	Globals.player = player

	player.follow_camera(camera)
	player.player_has_died.connect(reload_game)

func _physics_process(_delta: float) -> void:
	if is_instance_valid(Globals.player):
		player = Globals.player

	# restante do código...

	if Globals.seg <= -1:
		Globals.min -= 1
		Globals.seg = 59
	if pass_one_seg:
		pass_one_seg = false
		await get_tree().create_timer(1).timeout
		Globals.seg -= 1
		pass_one_seg = true
	if Globals.min < 0:
		Globals.player = null
		get_tree().change_scene_to_file(LEVEL_ID)

	_player_forget_something()

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

func _player_forget_something():
	if not is_instance_valid(Globals.player):
		return

	player = Globals.player

	if Globals.mangos < 30 or Globals.score < 15:
		if player.global_position.x >= 5190:
			back.visible = true
			label.text = "Você está esquecendo algo!"
			while label.visible_ratio < 1:
				await get_tree().create_timer(0.01).timeout
				label.visible_characters += 1
	else:
		$barrier/collision.disabled = true
	if label.visible_ratio == 1 and label.text == "Você está esquecendo algo!":
		await get_tree().create_timer(1).timeout
		back.visible = false
		label.visible_characters = 0 
	
