class_name StopOnImpactProjectileLogic extends Node2D

@export var projectile: Projectile

func _ready() -> void:
	projectile.impacted.connect(_on_impact)

func _on_impact(_body: Enemy, _atk: Attack, _data: ProjectileData) -> void:
	projectile.speed = 0.0
