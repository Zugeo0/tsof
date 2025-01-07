@icon("res://game/game.svg")
class_name Game extends Node2D

static var _instance: Game

@export var run_manager: RunManager
@export var level_manager: LevelManager
@export var player: Player
@export var ability_manager: AbilityManager
@export var ability_picker: AbilityPicker

func _init() -> void:
	_instance = self

static func get_instance() -> Game:
	return _instance

static func get_run_manager() -> RunManager:
	return _instance.run_manager

static func get_level_manager() -> LevelManager:
	return _instance.level_manager

static func get_enemy_manager() -> EnemyManager:
	return _instance.level_manager.get_enemy_manager()

static func get_player() -> Player:
	return _instance.player

static func get_ability_manager() -> AbilityManager:
	return _instance.ability_manager

static func get_ability_picker() -> AbilityPicker:
	return _instance.ability_picker
