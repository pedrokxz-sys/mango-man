extends CanvasLayer

@onready var joystick: Sprite2D = $joystick

func _ready():
	var touch_to_mouse: bool = ProjectSettings.get_setting(
		"input_devices/pointing/emulate_touch_from_mouse"
	) as bool

	var is_mobile: bool = OS.has_feature("mobile")

	joystick.visible = touch_to_mouse or is_mobile
