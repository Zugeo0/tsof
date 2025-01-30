class_name EnemyChaseLogic extends EnemyLogic

var _target_velocity: Vector2 = Vector2.ZERO

@export var speed: float = 1.0
@export var acceleration: float = 8.0
@export var chase: bool = true

func physics_process(delta: float) -> void:
	var player = Game.get_player()
	var dir = (player.global_position - enemy.global_position).normalized()
	if chase:
		_target_velocity = dir * 100.0 * speed
	else:
		_target_velocity = Vector2.ZERO
	enemy.linear_velocity = enemy.linear_velocity.move_toward(_target_velocity, delta * acceleration * 100.0)

func add_force(force: Vector2, instant: bool = false) -> void:
	if instant:
		enemy.linear_velocity = force
	else:
		enemy.linear_velocity += force
