extends Node

var _player_class: PlayerStats

func set_run_class(player_class: PlayerStats) -> void:
	_player_class = player_class

func get_current_player_class() -> PlayerStats:
	return _player_class
