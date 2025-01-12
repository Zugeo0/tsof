@icon("res://game/enemies/enemy_logic/enemy_logic_controller.svg")
class_name EnemyLogicController extends Node

@export var enemy: Enemy
@export var paused: bool = false

func _ready() -> void:
	for child in get_children():
		if child is EnemyLogic:
			child._setup(enemy)

func _process(delta: float) -> void:
	if Game.get_enemy_manager().paused or paused:
		return
	
	for child in get_children():
		if child is EnemyLogic:
			child._evaluate_process()
	
	for child in get_children():
		if child is EnemyLogic:
			child._logic_process(delta)

func _physics_process(delta: float) -> void:
	if Game.get_enemy_manager().paused or paused:
		return
	
	for child in get_children():
		if child is EnemyLogic:
			child._logic_physics_process(delta)
