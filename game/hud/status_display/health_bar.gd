class_name HUDHealthBar extends ProgressBar

@onready var health_label: Label = $InfoContainer/Health
@onready var multiplier_label: Label = $InfoContainer/Multiplier
@onready var difference_visual: ProgressBar = $DifferenceVisual

const DIFF_SPEED: float = 8.0

func _process(delta: float) -> void:
	difference_visual.max_value = max_value
	difference_visual.value = lerpf(difference_visual.value, value - 0.1, delta * DIFF_SPEED)

func update_bar(health: int, max_health: int, multiplier: float) -> void:
	max_value = max_health * multiplier
	value = health
	health_label.text = "%d/%d" % [health, max_health * multiplier]
	multiplier_label.visible = multiplier != 1.0
	multiplier_label.text = "+(%d%%)" % (multiplier * 100)
	
	if multiplier > 1.0:
		multiplier_label.label_settings.font_color = Color("#00be4b")
	else:
		multiplier_label.label_settings.font_color = Color("#fb0046")
