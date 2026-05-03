extends CharacterBody2D

const jump_force = -200
const speed = 150

@onready var player_detector := $player_detector as Area2D
@onready var texture := $texture as Sprite2D
@onready var animator := $animator as AnimationPlayer
@onready var wall_detector := $wall_detector as RayCast2D

var has_been_startle := false
var running = false
@export var diretion = 1


func _ready() -> void:
	texture.scale.x = diretion
	wall_detector.scale.x = diretion
	player_detector.scale.x = diretion

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	#if !has_been_startle:
		#has_been_startle = true
		#animator.play("startle")
		#texture.scale.x = diretion * -1

	if animator.current_animation == "startle":
		if is_on_floor():
			velocity.y = jump_force

	if wall_detector.is_colliding():
		diretion *= -1
		wall_detector.scale.x = diretion
		texture.scale.x = diretion * -1

	if running:
		animator.play("running")
		velocity.x = speed * diretion

	move_and_slide()


func _on_animator_animation_finished(anim_name: StringName) -> void:
	if anim_name == "startle":
		running = true

func _on_player_detector_body_entered(body: Node2D) -> void:
	if body != self and !has_been_startle:
		has_been_startle = true
		
		# Descobre de que lado o player está
		var player_is_right := body.global_position.x > global_position.x
		
		# Se o player está à direita, o coelho corre pra esquerda
		# Se o player está à esquerda, o coelho corre pra direita
		if player_is_right:
			diretion = -1
		else:
			diretion = 1
		
		# Atualiza os sprites/detectores para o lado correto
		texture.scale.x = diretion * -1
		wall_detector.scale.x = diretion
		player_detector.scale.x = diretion
		
		animator.play("startle")
