extends CharacterBody2D

func _ready() -> void:
	velocity = Vector2(randf_range(-75, 75), -100)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += Vector2(0, 500) * delta

	rotation += 1

	if is_on_floor():
		queue_free()

	move_and_slide()
