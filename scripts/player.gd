extends CharacterBody2D

#constantes de velocidade e força do pulo
const SPEED = 150.0
const JUMP_FORCE = -300.0

#variaveis referentes aos nodes q eu vou usar no script
@onready var animator := $animator as AnimationPlayer
@onready var texture := $texture as Sprite2D
@onready var remote := $remote as RemoteTransform2D

signal health_changed()

@export var health : int = 48

var damage_areas
#vetor do knockback
var knockback_vector := Vector2.ZERO
#estado de atacando
var is_attacking : bool = false

func _ready() -> void:
	damage_areas = get_tree().get_nodes_in_group("damage")
	for damage_area in damage_areas:
		damage_area.body_entered.connect(_on_damage_area_body_entered.bind(damage_area))

func _on_damage_area_body_entered(body: Node2D, damage_area: Area2D) -> void:
	if body == self:
		take_damage(damage_area)

func _physics_process(delta: float) -> void:
	# gravidade
	if not is_on_floor():
		velocity += get_gravity() * delta

	# pulo
	if Input.is_action_just_pressed("ui_accept") and is_on_floor() and !is_attacking:
		velocity.y = JUMP_FORCE

	# esquerda/direita
	var direction := Input.get_axis("ui_left", "ui_right")

	# trava movimento durante ataque
	if !is_attacking:
	# movimento e direção
		if direction != 0:
			velocity.x = direction * SPEED
			texture.scale.x = direction
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
	# trava movimento durante ataque
	else:
		velocity.x = 0

#se o vetor do knockback nao for zero a velocidade e igual a do vetor do knockback
	if knockback_vector != Vector2.ZERO:
		velocity = knockback_vector

	# iniciar ataque
	if Input.is_action_just_pressed("ui_attack") and !is_attacking:
		is_attacking = true
		animator.play("attack")

	handle_animation(direction)


	move_and_slide()



#animaçoes
func handle_animation(direction):
	if is_attacking:
		return
	if not is_on_floor():
		if velocity.y < 0:
			animator.play("jump")
		else:
			animator.play("fall")
	elif direction != 0:
		animator.play("run")
	else:
		animator.play("idle")

#se um animal entrar encotato com o hitbox ele some
func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("animals"):
		body.queue_free()

#quando a animaçao de ataque terminar o estado de ataque e falso
func _on_animator_animation_finished(anim_name: StringName) -> void:
	if anim_name == "attack":
		is_attacking = false

func follow_camera(camera):
	var camera_path = camera.get_path()
	remote.remote_path = camera_path

func take_damage(damage_area: Area2D) -> void:
	var enemy = damage_area.get_parent()  # pega o hedgehog
	
	if health > 0:
		health -= enemy.damage
		health_changed.emit()
	else:
		queue_free()

	# knockback
	var knockback_force := Vector2.ZERO
	
	if $ray_right.is_colliding():
		knockback_force = Vector2(-300, -300)
	elif $ray_left.is_colliding():
		knockback_force = Vector2(300, -300)

	knockback_vector = knockback_force
	
	var tween := get_tree().create_tween()
	tween.parallel().tween_property(self, "knockback_vector", Vector2.ZERO, 0.25)
	
	texture.modulate = Color(1,0,0,1)
	
	tween.parallel().tween_property(texture, "modulate", Color(1,1,1,1), 0.25)
