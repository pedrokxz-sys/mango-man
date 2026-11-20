extends Control

@onready var play_btn: Button = $MarginContainer/HBoxContainer/VBoxContainer/play_btn
@onready var anim: AnimationPlayer = $anim

#func _ready():
	#var popup = $opitions_menu/ScrollContainer/HBoxContainer/VBoxContainer/resolution_btn.get_popup()
#
	#print("Popup visível: ", popup.visible)
	#print("Popup itens: ", popup.item_count)
	#print("Popup position: ", popup.position)
	#print("Popup size: ", popup.size)
	#print("Popup visible: ", popup.visible)

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

func _on_video_btn_pressed() -> void:
	print("video")

#func _on_anim_animation_finished(anim_name: StringName) -> void:
	#if anim_name == "reveal":
		#play_btn.grab_focus()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept") or (event is InputEventScreenTouch and event.pressed):
		anim.speed_scale = 100
