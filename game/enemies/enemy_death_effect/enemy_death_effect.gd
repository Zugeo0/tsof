class_name EnemyDeathEffect extends Node2D

@onready var gpu_particles: GPUParticles2D = $GPUParticles2D

func _ready() -> void:
	gpu_particles.emitting = true
