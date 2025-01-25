@icon("res://game/hud/hurt_overlay/hurt_overlay.svg")
class_name HurtOverlay extends TextureRect

@onready var player: Player = %Player

@export var pulse_speed: float = 8.0
@export var pulse_strength: float = 0.1
@export_range(1, 8, 0.5) var pulse_impactness: float = 4.0

var _pulse_timer: float = 0.0

func _process(delta: float) -> void:
	_pulse_timer += delta
	
	var percentage = float(player.health) / (player.player_stats.max_health * player.player_stats.max_health_mod)
	var pulse_offset = pow(abs(sin(_pulse_timer * pulse_speed)), 4.0) * pulse_strength
	
	percentage = 1 - clamp(percentage + pulse_offset, 0.0, 1.0)
	modulate = Color.WHITE * percentage
