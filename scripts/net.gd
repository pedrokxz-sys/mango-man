extends CharacterBody2D

@onready var anim: AnimatedSprite2D = $anim

var net_up = true
var net_collect = false

func _ready() -> void:
	await get_tree().create_timer(0.35).timeout
	net_up = false

func _physics_process(_delta: float) -> void:
	if net_up:
		velocity.y = -220
	else:
		velocity += Vector2(0, 35)

	if is_on_floor():
		queue_free()

	_animations()
	move_and_slide()


func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("animals"):
		body.queue_free()
		net_collect = true
		Globals.score += 1

func _animations():
	if net_collect:
		anim.play("collect")
	elif velocity.y > 0:
		anim.play("fall")
