extends CharacterBody2D

#constantes de velocidade e força do pulo
const SPEED = 150.0
const JUMP_FORCE = -300.0

#variaveis referentes aos nodes q eu vou usar no script
@onready var animator := $animator as AnimationPlayer
@onready var texture := $texture as Sprite2D
@onready var remote := $remote as RemoteTransform2D

var damage_areas

#vetor do knockback
var knockback_vector := Vector2.ZERO
#estado de atacando
var is_attacking : bool = false

signal player_has_died

func _ready() -> void:
	damage_areas = get_tree().get_nodes_in_group("damage")
	for damage_area in damage_areas:
		damage_area.area_entered.connect(take_damage.bind(damage_area))

func _physics_process(delta: float) -> void:
	# gravidade
	if not is_on_floor():
		velocity += get_gravity() * delta

	# pulo
	if Input.is_action_just_pressed("ui_accept") and is_on_floor() and !is_attacking and !DiologManager.is_message_active:
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
	# diminui o movimento durante ataque
	else:
		velocity.x = direction * SPEED / 2

#se o vetor do knockback nao for zero a velocidade e igual a do vetor do knockback
	if knockback_vector != Vector2.ZERO:
		velocity = knockback_vector

	# iniciar ataque
	if Input.is_action_just_pressed("ui_collect") and !is_attacking:
		is_attacking = true
		animator.play("collect")

	handle_animation(direction)
	
	if DiologManager.is_message_active:
		velocity.x = 0

		var sign_pos = DiologManager.dialog_source_position

		if sign_pos.x < global_position.x:
			look_left()
		else:
			look_right()

	move_and_slide()
	return

#animaçoes
func handle_animation(direction):
	if is_attacking:
		return
	if not is_on_floor():
		if velocity.y < 0:
			animator.play("jump")
		else:
			animator.play("fall")
	elif direction != 0 and !DiologManager.is_message_active:
		animator.play("run")
	else:
		animator.play("idle")

#se um animal entrar encotato com o hitbox ele some
func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("animals"):
		body.queue_free()

#quando a animaçao de ataque terminar o estado de ataque e falso
func _on_animator_animation_finished(anim_name: StringName) -> void:
	if anim_name == "collect":
		is_attacking = false

func follow_camera(camera):
	var camera_path = camera.get_path()
	remote.remote_path = camera_path

func _on_hurtbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("damage"):
		var dmg: int = area.damage
		
		# descobre o lado automaticamente
		var dx: float = global_position.x - area.global_position.x
		var dir: float = 1.0 if dx >= 0.0 else -1.0
		
		# usa o knockback que veio do damage
		var knock: Vector2 = area.knockback
		knock.x *= dir
		
		take_damage(dmg, knock)

func take_damage(damage: int, knockback: Vector2) -> void:
	Globals.health -= damage
	Globals.health_changed.emit()

	knockback_vector = knockback

	var tween := get_tree().create_tween()

	# volta o knockback ao normal
	tween.tween_property(self, "knockback_vector", Vector2.ZERO, 0.25)

	# efeito vermelho
	texture.modulate = Color(1, 0, 0, 1)
	tween.parallel().tween_property(texture, "modulate", Color(1, 1, 1, 1), 0.25)

	if Globals.health <= 0:
		queue_free()
		emit_signal("player_has_died")

func look_right():
	texture.scale.x = 1
func look_left():
	texture.scale.x = -1

func handle_death_zone():
	Globals.health -= 16
	visible = false
	set_physics_process(false)
	
	await get_tree().create_timer(1.0).timeout
	Globals.respawn_player()
	visible = true
	set_physics_process(true)

	if Globals.health <= 0:
		queue_free()
		emit_signal("player_has_died")
