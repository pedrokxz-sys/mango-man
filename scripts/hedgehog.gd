extends CharacterBody2D

#constantes de velocidade e pulo
const speed := 30
const jump := -200

#variaveis referentes as nodes que vou usar no script
@onready var texture: Sprite2D = $texture
@onready var animator: AnimationPlayer = $animator
@onready var wall_detector: RayCast2D = $wall_detector
@onready var player_detector: RayCast2D = $player_detector
@onready var rolling_timer: Timer = $rolling_timer

#variaveis para indicar qual e o estado do ouriço
var rolling := false
var walking := true
var is_a_ball := false

#direçao que ele começa o jogo
@export var diretion := -1

#isso so toca uma vez pra ajeitar a direçao do ouri no começo do jogo
func _ready() -> void:
	texture.scale.x = diretion * -1
	wall_detector.scale.x = diretion * -1
	player_detector.scale.x = diretion * -1

func _physics_process(delta: float) -> void:
#gravidade:
	if !is_on_floor():
		velocity += get_gravity() * delta

#quando o ouriço ver o player ele vira uma bola
	if player_detector.is_colliding() and walking:
		walking = false
		is_a_ball = true
		animator.play("ball")
		if is_on_floor():
			velocity.y = jump

#ele vira para o outro lado quando bate na parede
	if wall_detector.is_colliding():
		diretion *= -1
		wall_detector.scale.x = diretion * -1
		texture.scale.x = diretion * -1
		player_detector.scale.x = diretion * -1

#quando ele tiver rolando toca animaçao de rolando e fica mais rapido
	if rolling:
		animator.play("rolling")
		velocity.x = diretion * speed * 3
#quando ele estiver andando toca a animaçao de andando e fica mais lento
	elif walking:
		animator.play("walking")
		velocity.x = diretion * speed

	move_and_slide()

#quando a animaçao de ball acabar ele começar a rolar e um timer que define o tempo que fica rolando começa
func _on_animator_animation_finished(anim_name: StringName) -> void:
	if anim_name == "ball":
		walking = false
		is_a_ball = false
		rolling = true
		rolling_timer.start()

#quando o tempo de rolar acaba ele volta a andar
func _on_rolling_timer_timeout() -> void:
	walking = true
	rolling = false
