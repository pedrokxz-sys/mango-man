extends Control

@onready var mango_counter: Label = $container/mango_container/mango_counter
@onready var score_counter: Label = $container/score_container/score_counter
@onready var min_counter: Label = $container/timer_container/min_counter
@onready var seg_counter: Label = $container/timer_container/seg_counter

func _ready() -> void:
	mango_counter.text = str("%03d" % Globals.mangos)
	score_counter.text = str("%02d" % Globals.score)
	min_counter.text = str("%02d" % Globals.min)
	seg_counter.text = str("%02d" % Globals.seg)

func _process(_delta: float) -> void:
	mango_counter.text = str("%03d" % Globals.mangos)
	score_counter.text = str("%02d" % Globals.score)
	min_counter.text = str("%02d" % Globals.min)
	seg_counter.text = str("%02d" % Globals.seg)
