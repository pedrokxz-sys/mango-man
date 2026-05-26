extends CharacterBody2D

const SPEED = 150
@onready var sprite: AnimatedSprite2D = $sprite


var last_dir := "down"

func _physics_process(delta: float) -> void:
	var direction: Vector2 = Input.get_vector(
		"ui_left", "ui_right", "ui_up", "ui_down"
	)

	velocity = direction * SPEED
	move_and_slide()

	update_anim(direction)

func update_anim(dir: Vector2):

	if dir == Vector2.ZERO:
		sprite.play("idle_" + last_dir)
		return

	# Decide qual eixo manda
	if abs(dir.x) > abs(dir.y):
		if dir.x > 0:
			last_dir = "right"
		else:
			last_dir = "left"
	else:
		if dir.y > 0:
			last_dir = "down"
		else:
			last_dir = "up"

	sprite.play("walk_" + last_dir)
