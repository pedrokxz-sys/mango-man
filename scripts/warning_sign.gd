extends Node2D

@onready var texture: Sprite2D = $texture
@onready var area_sign: Area2D = $area_sign

@export var lines : Array[String] = [
	"Procure os animais espalhados pela floresta!"
]

func _unhandled_input(event: InputEvent) -> void:
	if area_sign.get_overlapping_bodies().size() > 0:
		texture.show()
		if event.is_action_pressed("ui_crouch") && !DiologManager.is_message_active:
			texture.hide()
			DiologManager.start_message(global_position, lines)



	else:
		texture.hide()
