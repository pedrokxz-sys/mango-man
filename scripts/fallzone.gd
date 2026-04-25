extends Area2D

@export var damage := 16

func _on_body_entered(body: Node2D) -> void:
	if body.name == "player" and body.has_method("take_damage"):
		body.take_damage(self)
