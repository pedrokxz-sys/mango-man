extends Node

var _01_animal_room_finished:bool

var _01_town_finished:bool 

var _01_mayor_finished:bool 

var _02_town_finished:bool

var _03_town_finished:bool

func _ready() -> void:
	if _03_town_finished:
		_02_town_finished = true
	if _02_town_finished:
		_01_mayor_finished = true
	if _01_mayor_finished:
		_01_town_finished = true
	if _01_town_finished:
		_01_animal_room_finished = true

func _physics_process(_delta: float) -> void:
	if _03_town_finished:
		_02_town_finished = true
	if _02_town_finished:
		_01_mayor_finished = true
	if _01_mayor_finished:
		_01_town_finished = true
	if _01_town_finished:
		_01_animal_room_finished = true
