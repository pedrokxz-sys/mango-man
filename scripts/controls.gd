extends CanvasLayer

@onready var joystick: Sprite2D = $joystick
@onready var texture_button: TextureButton = $TextureButton

#func _ready():
	#var touch_to_mouse: bool = ProjectSettings.get_setting(
		#"input_devices/pointing/emulate_touch_from_mouse"
	#) as bool
#
	#var is_mobile: bool = OS.has_feature("mobile")
#
	#joystick.visible = touch_to_mouse or is_mobile

func _physics_process(_delta: float) -> void:
	if Globals.is_run:
		$ui_crouch.position.x = 308
		$ui_collect.visible = true
		$ui_up.visible = true
		if Globals.can_use_long_collect:
			$ui_long_collect.visible = true
		else:
			$ui_long_collect.visible = false
	else:
		$ui_crouch.position.x = 367
		$ui_collect.visible = false
		$ui_up.visible = false
