extends Area2D

#se um corpo tacar na fallzone ele some
func _on_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		body.take_damage(Vector2(0,-850))
