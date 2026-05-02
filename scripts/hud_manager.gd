extends Control

@onready var mango_counter: Label = $container/mango_container/mango_counter
@onready var score_counter: Label = $container/score_container/score_counter


func _ready() -> void:
	mango_counter.text = str("%03d" % Globals.mangos)
	score_counter.text = str("%02d" % Globals.score)

func _process(delta: float) -> void:
	mango_counter.text = str("%03d" % Globals.mangos)
	score_counter.text = str("%02d" % Globals.score)
