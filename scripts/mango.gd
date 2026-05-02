extends Area2D

@onready var anim: AnimatedSprite2D = $anim
var mango := 1

func _on_body_entered(body: Node2D) -> void:
	if body.name == "player":
		anim.play("collect")
		await  $collision.call_deferred("queue_free")
		Globals.mangos += mango

func _on_anim_animation_finished() -> void:
	queue_free()
