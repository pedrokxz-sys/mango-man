extends Node2D

@onready var collision: CollisionShape2D = $damage/collision
@onready var texture: Sprite2D = $texture


func _ready() -> void:
	collision.shape.size = texture.get_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
