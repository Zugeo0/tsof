@icon("res://game/enemies/enemy_manager/enemy_manager.svg")
class_name EnemyManager extends Node

var paused: bool = false

var _enemy_count: int = 0
var _active_boss: Boss

@export var spawn_settings: Array[EnemySpawnSettings]

const ENEMY_SPAWNER = preload("res://game/enemies/enemy_spawner/enemy_spawner.tscn")
const MAX_ENEMY_COUNT: int = 500

func _ready() -> void:
	for spawn in spawn_settings:
		var spawner: EnemySpawner = ENEMY_SPAWNER.instantiate()
		spawner.enemy_spawn = spawn
		add_child(spawner)

# TODO: Debug command
func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and event.keycode == KEY_P:
		paused = not paused

func spawn_enemy(enemy: EnemySpawnSettings, pos: Vector2) -> void:
	if _enemy_count >= MAX_ENEMY_COUNT:
		return
	
	var enemy_scene: Enemy = enemy.enemy.instantiate()
	var level: Level = Game.get_level_manager().get_current_level()
	level.add_object(enemy_scene, pos)
	
	_enemy_count += 1
	enemy_scene.death.connect(func(): _enemy_count -= 1)

func is_boss_active() -> bool:
	return _active_boss != null

func get_active_boss() -> Boss:
	return _active_boss

func register_boss(boss: Boss) -> void:
	_active_boss = boss
