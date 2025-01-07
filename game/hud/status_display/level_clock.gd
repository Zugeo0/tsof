extends Control

@onready var minutes: Label = $Minutes
@onready var seconds: Label = $Seconds

func _process(_delta: float) -> void:
	var time_remaining: float = Game.get_level_manager().get_time_left()
	
	if time_remaining >= 5999.0:
		time_remaining = 5999.0
	
	if time_remaining < 30.0:
		var should_show = time_remaining - int(time_remaining) > 0.5
		minutes.visible = should_show
		seconds.visible = should_show
	else:
		minutes.visible = true
		seconds.visible = true
	
	minutes.text = str(int(time_remaining) / 60).pad_zeros(2)
	seconds.text = str(int(time_remaining) % 60).pad_zeros(2)
