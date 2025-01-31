class_name ExplosionLogic extends Node2D

## Base logic node for explosion behavior

@export var explosion: Explosion

func _ready() -> void:
	explosion.explode.connect(_explode)

func _explode(_atk: Attack) -> void:
	pass
