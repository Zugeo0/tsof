class_name ExplosionSpawner extends Node

@export var projectile: Projectile
@export var explosion_scene: PackedScene
@export var base_radius: float = 10.0

func _ready() -> void:
	projectile.despawned.connect(_spawn_explosion)

func _spawn_explosion(pos: Vector2, atk: Attack, data: ProjectileData) -> void:
	var scene: Explosion = explosion_scene.instantiate()
	scene.init(atk, base_radius, data.area_of_effect_mod)
	Game.get_level_manager().get_current_level().add_object.call_deferred(scene, pos)
