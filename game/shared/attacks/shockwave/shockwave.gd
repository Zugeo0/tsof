extends Area2D

const SHOCKWAVE_SPEED: float = 30.0;

var _enemy_drops: bool = true

@onready var timer: Timer = $Timer
@onready var sprite_2d: Sprite2D = $Sprite2D

func _process(delta: float) -> void:
	scale += (Vector2.ONE * SHOCKWAVE_SPEED * delta)
	scale *= (1 + 4 * delta)
	
	var progress = 1 - timer.time_left / timer.wait_time
	var shader_material: ShaderMaterial = sprite_2d.material
	var mod = lerp(Color.WHITE, Color.TRANSPARENT, progress)
	shader_material.set_shader_parameter("modulate", mod)

func _on_body_entered(body: Node2D) -> void:
	var enemy: Enemy = body as Enemy
	enemy.kill(_enemy_drops)

func _on_timer_timeout() -> void:
	queue_free()

func set_enemy_drops(enemy_drops: bool) -> void:
	_enemy_drops = enemy_drops
