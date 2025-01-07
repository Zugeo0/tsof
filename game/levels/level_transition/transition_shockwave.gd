extends Area2D

const SHOCKWAVE_SPEED: float = 100.0;

signal shockwave_complete

func _process(delta: float) -> void:
	scale += (Vector2.ONE * SHOCKWAVE_SPEED * delta)
	scale *= (1 + 4 * delta)

func _on_body_entered(body: Node2D) -> void:
	var enemy: Enemy = body as Enemy
	enemy.kill(false)

func _on_timer_timeout() -> void:
	shockwave_complete.emit()
	queue_free()
