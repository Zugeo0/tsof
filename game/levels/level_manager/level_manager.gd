@icon("res://game/levels/level_manager/level_manager.svg")
class_name LevelManager extends Node

@onready var player: Player = %Player
@onready var active_level_node: Node2D = $ActiveLevel
@onready var timer: Timer = $Timer
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@export var levels: Array[LevelDetails]

var _active_level: int
var _active_level_scene: Level

const TRANSITION_SHOCKWAVE = preload("res://game/levels/level_transition/transition_shockwave.tscn")

func _ready() -> void:
	for child in active_level_node.get_children():
		child.queue_free()
	
	_load_level(_get_active_level_details(), false)

func _process(_delta: float) -> void:
	if not final_level():
		var current_level_data: LevelDetails = levels[_active_level]
		var next_level_data: LevelDetails = levels[_active_level + 1]
		var level_progress: float = get_level_progress()
		var zoom_level = lerpf(current_level_data.camera_zoom, next_level_data.camera_zoom, level_progress)
		Game.get_player().set_zoom(zoom_level)

func _load_level(level: LevelDetails, play_animation: bool) -> void:
	if play_animation:
		_transition_out(level)
		return
	
	_spawn_level(level)
	MusicManager.fade_in(level.music)

func _transition_out(level: LevelDetails) -> void:
	if _active_level_scene == null:
		return
	
	var shockwave = TRANSITION_SHOCKWAVE.instantiate()
	shockwave.shockwave_complete.connect(_transition_in.bind(level))
	shockwave.global_position = Game.get_player().global_position
	add_child(shockwave)
	
	for node in get_tree().get_nodes_in_group("Spawner"):
		node.queue_free()
	
	animation_player.play("level_transition_out")
	MusicManager.fade_out()
	Game.get_player().set_freeze(true)

func _transition_in(level: LevelDetails) -> void:
	_active_level_scene.queue_free()
	_spawn_level(level)
	
	animation_player.play("level_transition_in")
	
	_active_level_scene.get_enemy_manager().paused = true
	_active_level_scene.z_index = -1
	
	await animation_player.animation_finished
	
	_active_level_scene.get_enemy_manager().paused = false
	_active_level_scene.z_index = 0
	
	Game.get_player().set_freeze(false)
	MusicManager.start_immediate(level.music)

func _spawn_level(level: LevelDetails) -> void:
	var level_scene = level.scene.instantiate()
	active_level_node.add_child(level_scene)
	_active_level_scene = level_scene
	
	timer.start(level.duration)
	player.teleport(Vector2.ZERO)

func _get_active_level_details() -> LevelDetails:
	return levels[_active_level]

func get_current_level() -> Level:
	return _active_level_scene

func _add_positioned_child(parent: Node2D, node: Node2D, position: Vector2) -> void:
	parent.add_child(node)
	node.global_position = position

## Gets the amount of time left of the level in seconds
func get_time_left() -> float:
	return timer.time_left

## Gets the amount of time the level goes on for in seconds
func get_level_length() -> float:
	return timer.wait_time

func get_level_progress() -> float:
	return 1 - timer.time_left / timer.wait_time

func next_level() -> void:
	if final_level():
		return
	
	_active_level += 1
	_load_level(_get_active_level_details(), true)

func _on_timer_timeout() -> void:
	next_level()

func get_enemy_manager() -> EnemyManager:
	return _active_level_scene.get_enemy_manager()

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and event.keycode == KEY_B:
		timer.stop()
		next_level()

func final_level() -> bool:
	return _active_level + 1 >= levels.size()
