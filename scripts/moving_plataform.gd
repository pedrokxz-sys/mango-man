extends Node2D
#tempo que a plataforma espara quando chega no final:
const WAIT_DURATION := 1

#armazena as propiedades do animatablebody2d:
@onready var plataform := $wood as AnimatableBody2D
#armazena a velocidade da plataforma:
@export var move_speed := 3.0
#armazena a distancia que a plataforma percorre:
@export var distance := 192
#diz se a plataforma move para na horizontal ou veritical:
@export var move_horizontal := true

#caaminho da plataforma: 
var follow := Vector2.ZERO
#centro da plataforma:
var plataform_center := 16

#começa a mover a plataforma:
func _ready() -> void:
	move_plataform()
#mantém a plataforma em movimento:
func _physics_process(delta: float) -> void:
	plataform.position = plataform.position.lerp(follow, 0.5)

#cria o movimento da plataforma:
func move_plataform():
#direção da plateforma:
	var move_direction := Vector2.RIGHT * distance if move_horizontal else Vector2.UP * distance
#duração do movimento:
	var duration := move_direction.length() / float(move_speed * plataform_center)

#cria o antigo node de tween:
	var platafrom_tween = create_tween().set_loops().set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	platafrom_tween.tween_property(self, "follow", move_direction, duration).set_delay(WAIT_DURATION)
	platafrom_tween.tween_property(self, "follow", Vector2.ZERO, duration).set_delay(WAIT_DURATION * 2)
