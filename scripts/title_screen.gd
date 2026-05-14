extends Control

@onready var play_btn: Button = $MarginContainer/HBoxContainer/VBoxContainer/play_btn
@onready var anim: AnimationPlayer = $anim


func _on_play_btn_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/world_01.tscn")

func _on_options_btn_pressed() -> void:
	pass # Replace with function body.

func _on_quit_btn_pressed() -> void:
	get_tree().quit()

func _on_anim_animation_finished(anim_name: StringName) -> void:
	play_btn.grab_focus()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		anim.speed_scale = 100
