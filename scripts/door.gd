extends Area2D

@export var nextlevel : String = ""

@onready var animator: AnimationPlayer = $animator
@onready var texture: Sprite2D = $texture

var door_can_open := false
signal player_exit_hunter

func _on_body_entered(body: Node2D) -> void:
	if body.name == "player":
		door_can_open = true

func _on_body_exited(body: Node2D) -> void:
	if body.name == "player":
		door_can_open = false

func _process(_delta: float) -> void:
	if texture == null:
		return
	
	if door_can_open:
		texture.visible = true
		
		if Input.is_action_just_pressed("ui_crouch"):
			animator.play("goal")
			emit_signal("player_exit_hunter")
	else:
		texture.visible = false

func _on_animator_animation_finished(anim_name: StringName) -> void:
	if anim_name == "goal":
		await get_tree().create_timer(1.5).timeout
		get_tree().change_scene_to_file(nextlevel)
