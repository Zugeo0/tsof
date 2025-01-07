class_name EnemyHealthBar extends ProgressBar

@export var enemy: Enemy

@onready var health_bar_value: ProgressBar = $HealthBarValue

const HEALTH_DIFF_SPEED: float = 4.0

func _process(delta: float) -> void:
	health_bar_value.max_value = enemy.max_health
	health_bar_value.value = enemy.health
	max_value = enemy.max_health
	value = lerpf(value, enemy.health - 0.1, delta * HEALTH_DIFF_SPEED)
