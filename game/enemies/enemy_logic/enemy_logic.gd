@icon("res://game/enemies/enemy_logic/enemy_logic.svg")
class_name EnemyLogic extends Node

var enemy: Enemy

var _last_processed: bool = true
var should_process: bool = false

func _setup(active_enemy: Enemy) -> void:
	enemy = active_enemy
	ready()
	
	for child in get_children():
		if child is EnemyLogic:
			child._setup(active_enemy)

func _logic_process(delta: float) -> void:
	if not should_process:
		return
	
	process(delta)
	
	for child in get_children():
		if child is EnemyLogic:
			child._logic_process(delta)

func _logic_physics_process(delta: float) -> void:
	if not should_process:
		return
	
	physics_process(delta)
	
	for child in get_children():
		if child is EnemyLogic:
			child._logic_physics_process(delta)

func _evaluate_process() -> void:
	should_process = evaluate()
	
	if not should_process:
		_disable_process()
		return
	
	if not _last_processed:
		enabled()
	
	_last_processed = true
	
	for child in get_children():
		if child is EnemyLogic:
			child._evaluate_process()

func _disable_process() -> void:
	should_process = false
	
	if _last_processed:
		disabled()
	
	_last_processed = false
	
	for child in get_children():
		if child is EnemyLogic:
			child._disable_process() 

func evaluate() -> bool:
	return true

func ready() -> void:
	pass

func process(_delta: float) -> void:
	pass

func physics_process(_delta: float) -> void:
	pass

func enabled() -> void:
	pass

func disabled() -> void:
	pass
