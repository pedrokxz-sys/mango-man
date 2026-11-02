extends Node

var _01_animal_room_finished:bool

var _01_town_finished:bool

var _01_mayor_finised:bool

func _ready() -> void:
	if _01_mayor_finised == true:
		_01_town_finished = true
	if _01_town_finished == true:
		_01_animal_room_finished = true
	print(Cutscenes._01_animal_room_finished, Cutscenes._01_mayor_finised, Cutscenes._01_town_finished)

func _physics_process(_delta: float) -> void:
	if _01_mayor_finised == true:
		_01_town_finished = true
	if _01_town_finished == true:
		_01_animal_room_finished = true
