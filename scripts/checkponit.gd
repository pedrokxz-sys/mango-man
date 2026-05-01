extends Area2D

var is_active = false
@onready var anim = $anim
@onready var marker_2d: Marker2D = $marker_2d

func _on_body_entered(body: Node2D) -> void:
	if body.name != "player" or is_active:
		return
	activate_checkpoint()

func activate_checkpoint():
	Globals.current_checkpoint = marker_2d
	anim.play("raising")
	is_active = true

func _on_anim_animation_finished() -> void:
	if anim.animation == "raising":
		anim.play("checked")
		
