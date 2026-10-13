extends Area2D

@export var damage := 1
@export var knockback: Vector2 = Vector2(250, -450)


func _on_area_entered(_area: Area2D) -> void:
	if _area.name == "hurtbox":
		$audio_damage.play()
