@icon("res://game/hud/boss_bar/boss_bar.svg")
class_name BossBar extends TextureRect

@onready var progress_bar_diff: ProgressBar = $ProgressBarDiff
@onready var progress_bar_actual: ProgressBar = $ProgressBarDiff/ProgressBarActual
@onready var health_percentage: Label = $ProgressBarDiff/HealthPercentage
@onready var boss_name: Label = $BossName

const DIFF_SPEED: float = 4.0

func _process(delta: float) -> void:
	var boss_active = Game.get_enemy_manager().is_boss_active()
	visible = boss_active
	
	if not boss_active:
		return
	
	var boss: Boss = Game.get_enemy_manager().get_active_boss()
	progress_bar_actual.value = boss.health
	progress_bar_actual.max_value = boss.max_health
	progress_bar_diff.max_value = progress_bar_actual.max_value
	progress_bar_diff.value = lerpf(progress_bar_diff.value, boss.health - 0.1, delta * DIFF_SPEED)
	
	boss_name.text = boss.name
	health_percentage.text = "%d%%" % int((float(boss.health) / boss.max_health) * 100.0)
