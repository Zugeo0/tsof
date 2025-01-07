@icon("res://game/levels/level_manager/level.svg")
class_name Level extends Node2D

@export var enemy_manager: EnemyManager

func get_enemy_manager() -> EnemyManager:
	return enemy_manager

func add_object(node: Node2D, pos: Vector2) -> void:
	add_child(node)
	node.global_position = pos
