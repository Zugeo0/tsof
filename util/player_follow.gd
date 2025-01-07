@icon("res://util/player_follow.svg")
class_name PlayerFollow extends Node2D

func _process(_delta: float) -> void:
	global_position = Game.get_player().global_position
