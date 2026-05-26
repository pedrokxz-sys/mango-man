extends Node2D

@onready var sprite: Sprite2D = $texture
@onready var collision: CollisionShape2D = $damage/collision

func _ready() -> void:
	await get_tree().process_frame
	
	var rect := RectangleShape2D.new()
	rect.size = sprite.region_rect.size
	
	collision.shape = rect
