extends Area2D

# variavel referente ao animatedsrite2d
@onready var anim: AnimatedSprite2D = $anim

# se um corpo entrar no bouce e vai quicar e o bouce vai tocar a animaçao de bouce
func _on_body_entered(body):
	body.velocity.y = -450
	anim.play("bounce")
