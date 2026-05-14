extends CanvasLayer

@onready var resume_btn: Button = $menu_holder/resume_btn

func _ready() -> void:
	visible = false

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		visible = true
		get_tree().paused = true
		resume_btn.grab_focus()

func _on_resume_btn_pressed() -> void:
	get_tree().paused = false
	visible = false

func _on_menu_btn_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://levels/title_screen.tscn")

func _on_quit_game_btn_pressed() -> void:
	get_tree().quit()
