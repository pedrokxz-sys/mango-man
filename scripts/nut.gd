extends CharacterBody2D

@onready var anim: AnimatedSprite2D = $anim

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	if is_on_floor():
		anim.play("break")

	move_and_slide()


func _on_anim_animation_finished() -> void:
	queue_free()
