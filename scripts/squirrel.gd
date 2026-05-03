extends CharacterBody2D

const NUT = preload("uid://bj215nca8v5k")

@onready var animator: AnimationPlayer = $animator
@onready var texture: Sprite2D = $texture
@onready var player_detector: RayCast2D = $player_detector
@onready var shooting_timer: Timer = $shooting_timer

var SPEED = 100.0
const JUMP_VELOCITY = -200.0

@export var direction = -1

var is_shooting = false

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta * 0.24

	# Handle jump.
	if is_on_floor():
		
		animator.play("jump")
		direction *= -1
		texture.scale.x *= -1
		velocity.y = JUMP_VELOCITY

	if player_detector.is_colliding():
		velocity.x = 0
		if shooting_timer.is_stopped():
			animator.play("shooting")
			shooting_timer.start()
	else:
		velocity.x = SPEED * direction

	move_and_slide()


func _on_animator_animation_finished(anim_name: StringName) -> void:
	animator.play("flying")

func spawn_nut():
	var new_nut = NUT.instantiate()
	add_child(new_nut)
