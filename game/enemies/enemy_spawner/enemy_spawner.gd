@icon("res://game/enemies/enemy_spawner/enemy_spawner.svg")
class_name EnemySpawner extends Node2D

@export var enemy_spawn: EnemySpawnSettings

@onready var spawn_timer: Timer = $SpawnTimer
@onready var start_timer: Timer = $StartTimer
@onready var spawn_duration_timer: Timer = $SpawnDurationTimer

func _ready() -> void:
	spawn_timer.timeout.connect(_spawn_batch)
	
	if enemy_spawn.start_time == 0:
		_start_spawning.call_deferred()
		return
		
	start_timer.start(enemy_spawn.start_time)
	start_timer.timeout.connect(_start_spawning)

func _start_spawning() -> void:
	if enemy_spawn.spawn_duration > 0:
		spawn_duration_timer.start(enemy_spawn.spawn_duration)
		spawn_duration_timer.timeout.connect(queue_free)
	
	_spawn_batch()

func _spawn_batch() -> void:
	var player = Game.get_player()
	var spawn_range = lerpf(enemy_spawn.min_spawn_range, enemy_spawn.max_spawn_range, randf())
	var group_pos = player.global_position + Vector2.from_angle(randf() * 2 * PI) * spawn_range
	var group_size = randi_range(enemy_spawn.min_group_size, enemy_spawn.max_group_size)
	
	for _i in range(group_size):
		var pos_offset = Vector2.from_angle(randf() * 2.0 * PI) * (30.0 + randf() * 50.0)
		Game.get_enemy_manager().spawn_enemy(enemy_spawn, group_pos + pos_offset)
	
	spawn_timer.start(_get_spawn_time())

func _get_spawn_time() -> float:
	if enemy_spawn.spawn_duration > 0.0:
		var duration_percentage = spawn_duration_timer.time_left / spawn_duration_timer.wait_time
		return enemy_spawn.spawn_rate.sample(duration_percentage)
	
	var level_manager: LevelManager = Game.get_level_manager()
	var adj_time_left = level_manager.get_time_left() - enemy_spawn.start_time
	var adj_level_length = level_manager.get_level_length() - enemy_spawn.start_time
	var level_percentage = adj_time_left / adj_level_length
	return enemy_spawn.spawn_rate.sample(level_percentage)
