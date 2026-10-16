extends CharacterBody2D

@onready var anim: AnimationPlayer = $anim

const SPEED = 300.0
const JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Globals.player.velocity.x > 0:
		$texture.scale.x = -1
	if Globals.player.velocity.x < 0:
		$texture.scale.x = 1

	if !Cutscenes._01_town_finished and Cutscenes._01_animal_room_finished:
		_hunter_with_player()

	_what_anim()

	move_and_slide()

func _hunter_with_player():
	if Globals.player.velocity.x > 0:
		if global_position.x +16 >= Globals.player.global_position.x:
			velocity.x = 0 
		else:
			velocity.x = Globals.player.velocity.x 
	if Globals.player.velocity.x < 0:
		if global_position.x -16 <= Globals.player.global_position.x:
			velocity.x = 0 
		else:
			velocity.x = Globals.player.velocity.x 
	if Globals.player.velocity.x == 0:
		velocity.x = 0

func _what_anim():
	if velocity.x != 0:
		anim.play("walk")
	if velocity.x == 0:
		anim.play("idle")
