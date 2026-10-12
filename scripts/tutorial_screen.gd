extends CanvasLayer

var dialog_01: String = "Mova-se com A & D"
var dialog_02: String = "Pule com W"
var dialog_03: String = "Aproxime-se e colete os animais com P"
var dialog_04: String = "Encontre todos os animais!"
var dialog_05: String = "Colete todas as mangas roubadas!"
var dialog_06: String = "Use as bandeiras como checkpoint!"
var dialog_07: String = "Agora você está pronto pra ir!"
var dialog_08: String = "Você está esquecendo algo!"

var tutorial_start = false
var dialog4_finished = false
var dialog5_finished = false
var dialog6_finished = false

@onready var player: CharacterBody2D
@onready var label: RichTextLabel = $control/HBoxContainer/VBoxContainer/label
@onready var back: ColorRect = $control/back
@onready var score_container: HBoxContainer = $"../HUD/control/container/score_container"
@onready var mango_container: HBoxContainer = $"../HUD/control/container/mango_container"
@onready var player_health: Node2D = $"../HUD/player_health"

func _ready() -> void:
	if is_instance_valid(Globals.player):
		player = Globals.player

func _physics_process(_delta: float) -> void:
	if not is_instance_valid(Globals.player):
		return

	player = Globals.player

	
	if !tutorial_start:
		await get_tree().create_timer(.5).timeout
		tutorial_start = true
		await get_tree().create_timer(0.5).timeout
		back.visible = true
		label.text = dialog_01
		while label.visible_ratio <= 1 and player.velocity.x == 0:
			await  get_tree().create_timer(0.01).timeout
			label.visible_characters += 1
	if label.text == dialog_01 and player.velocity.x != 0:
		back.visible = false
		label.visible_characters = 0

	if label.text == dialog_01 and back.visible == false:
		if player.global_position.x >= 100:
			label.text = dialog_02
			back.visible = true
			while label.visible_ratio < 1 and player.velocity.y == 0:
				await get_tree().create_timer(0.01).timeout
				label.visible_characters += 1
	if label.text == dialog_02 and player.velocity.y != 0:
		back.visible = false
		label.visible_characters = 0

	if label.text == dialog_02 and back.visible == false:
		if player.global_position.x >= 225:
			label.text = dialog_03
			back.visible = true
			while label.visible_ratio < 1 and player.global_position.x <= 280:
				await get_tree().create_timer(0.01).timeout
				label.visible_characters += 1
	if label.text == dialog_03 and player.global_position.x >= 280:
		back.visible = false
		label.visible_characters = 0


	if !label.text == dialog_04 and back.visible == false and !dialog4_finished:
		if Globals.score == 1:
			print("dialog acabou")
			dialog4_finished = true
			label.text = dialog_04
			back.visible = true
			score_container.visible = true
			while label.visible_ratio < 1:
				await get_tree().create_timer(0.01).timeout
				label.visible_characters += 1
	if label.text == dialog_04 and label.visible_ratio == 1:
		await get_tree().create_timer(1).timeout
		back.visible = false 
		label.visible_characters = 0

	if !label.text == dialog_05 and back.visible == false and !dialog5_finished:
		if Globals.mangos == 1:
			dialog5_finished = true
			label.text = dialog_05
			back.visible = true
			mango_container.visible = true
			while label.visible_ratio < 1:
				await get_tree().create_timer(0.01).timeout
				label.visible_characters += 1
				back.visible = true
	if label.text == dialog_05 and label.visible_ratio == 1:
		await get_tree().create_timer(1).timeout
		back.visible = false 
		label.visible_characters = 0

	if !label.text == dialog_06 and back.visible == false and !dialog6_finished:
		if player.global_position.x >= 976:
			dialog6_finished = true
			label.text = dialog_06
			back.visible = true
			player_health.visible = true
			while label.visible_ratio < 1:
				await get_tree().create_timer(0.01).timeout
				label.visible_characters += 1
	if label.text == dialog_06 and label.visible_ratio == 1:
		await get_tree().create_timer(1).timeout
		back.visible = false 
		label.visible_characters = 0

	if !label.text == dialog_07 and back.visible == false:
		if player.global_position.x >= 1352:
			label.text = dialog_07
			back.visible = true
			while label.visible_ratio < 1:
				await get_tree().create_timer(0.01).timeout
				label.visible_characters += 1
	if label.text == dialog_07 and label.visible_ratio == 1:
		await get_tree().create_timer(1).timeout
		back.visible = false 
		label.visible_characters = 0

	if Globals.mangos < 2 or Globals.score < 3:
		if player.global_position.x >= 1330:
			label.text = dialog_08
			back.visible = true
			while label.visible_ratio < 1:
				await get_tree().create_timer(0.01).timeout
				label.visible_characters += 1
	else:
		$"../barrier/collision".disabled = true
	if label.text == dialog_08 and label.visible_ratio == 1:
		await get_tree().create_timer(1).timeout
		back.visible = false 
		label.visible_characters = 0
