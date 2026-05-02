extends Node2D

@onready var anim: AnimatedSprite2D = $anim


func _process(delta: float) -> void:
	if Globals.health == 6:
		anim.play("3")
	
	if Globals.health == 5:
		anim.play("2.5")
	
	if Globals.health == 4:
		anim.play("2")
	
	if Globals.health == 3:
		anim.play("1.5")
	
	if Globals.health == 2:
		anim.play("1")
	
	if Globals.health == 1:
		anim.play("0.5")
	
	if Globals.health == 0:
		anim.play("0")
	
	Globals.health_changed.connect(health_changed)

func health_changed():
	var tween := get_tree().create_tween()

	# efeito vermelho
	anim.modulate = Color(1, 0, 0, 1)
	tween.parallel().tween_property(anim, "modulate", Color(1, 1, 1, 1), 0.25)
