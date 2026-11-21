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
		$Control/ui_crouch.position.x = 308
		$Control/ui_collect.visible = true
		$Control/ui_up.visible = true
		if Globals.can_use_long_collect:
			$Control/ui_long_collect.visible = true
		else:
			$Control/ui_long_collect.visible = false
	else:
		$Control/ui_crouch.position.x = 367
		$Control/ui_collect.visible = false
		$Control/ui_up.visible = false
