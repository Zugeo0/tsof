extends Node

var _player_class: PlayerClass

func set_run_class(player_class: PlayerClass) -> void:
	_player_class = player_class

func get_current_player_class() -> PlayerClass:
	return _player_class
