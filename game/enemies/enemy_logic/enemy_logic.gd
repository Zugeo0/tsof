@icon("res://game/enemies/enemy_logic/enemy_logic.svg")
class_name EnemyLogic extends Node

var enemy: Enemy

func _setup(active_enemy: Enemy) -> void:
	enemy = active_enemy
	ready()
	
	for child in get_children():
		if child is EnemyLogic:
			child._setup(active_enemy)

func _logic_process(delta: float) -> void:
	if not evaluate():
		return
	
	process(delta)
	
	for child in get_children():
		if child is EnemyLogic:
			child._logic_process(delta)

func _logic_physics_process(delta: float) -> void:
	if not evaluate():
		return
	
	physics_process(delta)
	
	for child in get_children():
		if child is EnemyLogic:
			child._logic_physics_process(delta)

func evaluate() -> bool:
	return true

func ready() -> void:
	pass

func process(_delta: float) -> void:
	pass

func physics_process(_delta: float) -> void:
	pass
