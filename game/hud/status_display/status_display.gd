@icon("res://game/hud/status_display/status_display.svg")
class_name StatusDisplay extends TextureRect

@onready var level_counter: Label = $LevelCounter
@onready var player: Player = %Player

@onready var health_bar: HUDHealthBar = $HealthBar
@onready var experience_bar: ExperienceBar = $ExperienceBar

func _process(_delta: float) -> void:
	level_counter.text = "%d" % player.current_level
	health_bar.update_bar(player.health, player.player_stats.max_health, player.player_stats.max_health_mod)
	experience_bar.update_bar(player.current_experience, player.get_xp_requirement(player.current_level))
