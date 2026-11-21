extends Control

@onready var play_btn: Button = $MarginContainer/HBoxContainer/VBoxContainer/play_btn
@onready var anim: AnimationPlayer = $anim

@onready var resolution_btn: OptionButton = $opitions_menu/HBoxContainer/VBoxCenter/resolution_btn

func _ready() -> void:
	resolution_btn.clear()

	resolution_btn.add_item("Automático", 0)
	resolution_btn.add_item("16:9", 1)
	resolution_btn.add_item("16:10", 2)
	resolution_btn.add_item("18:9", 3)
	resolution_btn.add_item("19.5:9", 4)
	resolution_btn.add_item("20:9", 5)

	update_resolution_button()

func update_resolution_button() -> void:
	var ratio = Globals.screen_ratio

	if ratio == 0.0:
		resolution_btn.select(0)
	elif is_equal_approx(ratio, 16.0 / 9.0):
		resolution_btn.select(1)
	elif is_equal_approx(ratio, 16.0 / 10.0):
		resolution_btn.select(2)
	elif is_equal_approx(ratio, 18.0 / 9.0):
		resolution_btn.select(3)
	elif is_equal_approx(ratio, 19.5 / 9.0):
		resolution_btn.select(4)
	elif is_equal_approx(ratio, 20.0 / 9.0):
		resolution_btn.select(5)

func _on_resolution_btn_item_selected(index: int) -> void:
	match index:
		0:
			Globals.screen_ratio = 0.0
		1:
			Globals.screen_ratio = 16.0 / 9.0
		2:
			Globals.screen_ratio = 16.0 / 10.0
		3:
			Globals.screen_ratio = 18.0 / 9.0
		4:
			Globals.screen_ratio = 19.5 / 9.0
		5:
			Globals.screen_ratio = 20.0 / 9.0

	Globals.save_screen_ratio()

func _physics_process(_delta: float) -> void:
	if Input.is_action_pressed("ui_cancel"):
		$opitions_menu.visible = false

func _on_play_btn_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/tutorial.tscn")

func _on_options_btn_pressed() -> void:
	$opitions_menu.visible = true

func _on_quit_btn_pressed() -> void:
	get_tree().quit()

func _on_esc_btn_pressed() -> void:
	$opitions_menu.visible = false


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept") or (event is InputEventScreenTouch and event.pressed):
		anim.speed_scale = 100
