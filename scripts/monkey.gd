extends CharacterBody2D

@onready var animator: AnimationPlayer = $animator
@onready var texture: Sprite2D = $texture

var player_has_been_detected = false
var tree_position := Vector2()

func _physics_process(_delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * _delta

	if tree_position != Vector2.ZERO:
		_moving_to_tree()

	move_and_slide()


func _on_player_detector_body_entered(_body: Node2D) -> void:
	if player_has_been_detected == false:
		animator.play("up")
		velocity.y = -300
	player_has_been_detected = true

func _on_tree_detector_body_entered(_body: Node2D) -> void:
	if _body.is_in_group("big_tree") and player_has_been_detected:
		tree_position = _body.global_position

func _moving_to_tree():
	if global_position.x < tree_position.x - 10:
		animator.play("run")
		texture.scale.x = 1
		velocity.x = 200
	if global_position.x > tree_position.x + 10:
		velocity.x = -200
		texture.scale.x = -1
		animator.play("run")
	if global_position.x < tree_position.x + 3 and global_position.x > tree_position.x - 3:
		velocity.x = 0
		if global_position.y - tree_position.y > -75:
			animator.play("climb")
			velocity.y = -60
		else:
			velocity.y = 0
			animator.play("attack")

func _on_animator_animation_finished(anim_name: StringName) -> void:
	if anim_name ==  "attack":
		texture.scale.x *= -1

func _spawn_stick():
	var stick = preload("res://prefabs/stick.tscn").instantiate()
	add_child(stick)
