class_name EnemyChaseLogic extends EnemyLogic

var _target_velocity: Vector2 = Vector2.ZERO

@export var speed: float = 1.0
@export var acceleration: float = 8.0

func physics_process(delta: float) -> void:
	var player = Game.get_player()
	var dir = (player.global_position - enemy.global_position).normalized()
	_target_velocity = dir * 100.0 * speed
	enemy.linear_velocity = enemy.linear_velocity.move_toward(_target_velocity, delta * acceleration * 100.0)
