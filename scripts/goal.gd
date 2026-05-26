extends Area2D

@export var nextlevel : String = ""
@onready var animator: AnimationPlayer = $animator

func _on_body_entered(body: Node2D) -> void:
	if body.name == "player":
		animator.play("goal")

func _on_animator_animation_finished(anim_name: StringName) -> void:
	if anim_name == "goal":
		await get_tree().create_timer(1.5)
		get_tree().change_scene_to_file(nextlevel)
