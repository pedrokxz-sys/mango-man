extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Globals.player.velocity.x > 0:
		$texture.scale.x = -1
		$wall_detector.scale.x = -1
	if Globals.player.velocity.x < 0:
		$texture.scale.x = 1
		$wall_detector.scale.x = 1

	move_and_slide()
