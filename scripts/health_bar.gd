extends ProgressBar

func _ready() -> void:
	Globals.health_changed.connect(health_update)
	health_update()

func health_update() -> void:
	value = Globals.health 
