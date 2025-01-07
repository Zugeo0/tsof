class_name BossDeathEffect extends Node2D

@onready var gpu_particles: GPUParticles2D = $GPUParticles2D

const SHOCKWAVE = preload("res://game/shockwave/shockwave.tscn")

func _ready() -> void:
	gpu_particles.emitting = true
	_spawn_shockwave.call_deferred()

func _spawn_shockwave() -> void:
	print(global_position)
	var shockwave = SHOCKWAVE.instantiate()
	Game.get_level_manager().get_current_level().add_object(shockwave, global_position)
