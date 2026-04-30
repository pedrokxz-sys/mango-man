extends Node

@onready var diolog_box_scene = preload("res://prefabs/dialog_box.tscn")

var dialog_source_position := Vector2.ZERO

var message_lines : Array[String] = []
var current_lines = 0 

var dialog_box
var dialog_box_position := Vector2.ZERO

var is_message_active := false
var can_advance_message := false

func start_message(position: Vector2, lines: Array[String]):
	if is_message_active:
		return
	
	dialog_source_position = position
	message_lines = lines
	current_lines = 0
	
	is_message_active = true
	show_text()
	
func show_text():
	dialog_box = diolog_box_scene.instantiate()
	dialog_box.text_display_finished.connect(_on_all_text_displayed)
	get_tree().current_scene.add_child(dialog_box)
	dialog_box.global_position = dialog_source_position
	dialog_box.display_text(message_lines[current_lines])
	can_advance_message = false

func _on_all_text_displayed():
	can_advance_message = true

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_crouch") and is_message_active and can_advance_message:
		dialog_box.queue_free()
		current_lines += 1
		
		if current_lines >= message_lines.size():
			is_message_active = false
			current_lines = 0
			return
			
		show_text()
