extends CanvasLayer

@onready var joystick := $joystick as Sprite2D
var touch_to_mouse : bool = ProjectSettings.get_setting("input_devices/pointing/emulate_touch_from_mouse") 

func _ready():
	if touch_to_mouse:
		joystick.visible = true
	if !touch_to_mouse:
		joystick.visible = false
