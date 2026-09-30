extends Control

var text_spped = 0.05

var id: int = 0
var data: Dictionary = {}

@export_category("Objects")
@export var _name: Label = null
@export var _dialog: RichTextLabel = null
@export var _faceset: TextureRect = null

func _ready() -> void:
	_initialize_dialog()

func _process(_delta: float) -> void:
	if Input.is_action_pressed("ui_crouch") and _dialog.visible_ratio < 1:
		text_spped = 0.01
		return
	else:
		text_spped = 0.05
	if Input.is_action_just_pressed("ui_crouch"):
		id += 1
		if id == data.size():
			queue_free()
			return
		_initialize_dialog()

func _initialize_dialog():
	_name.text = data[id]["_name"]
	_dialog.text = data[id]["_dialog"]
	_faceset.texture = load(data[id]["_faceset"])
	
	_dialog.visible_characters = 0
	while _dialog.visible_ratio < 1:
		await get_tree().create_timer(text_spped).timeout
		_dialog.visible_characters += 1
