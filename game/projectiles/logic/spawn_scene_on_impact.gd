class_name SpawnSceneOnImpactLogic extends Node2D

@export var scene_to_spawn: PackedScene
@export var free_on_scene_spawn: bool = true
@export var can_pierce: bool = true

@export var projectile: Projectile

func _ready() -> void:
	projectile.impacted.connect(_on_impact)

func _on_impact(body: Node2D) -> void:
	var scene = scene_to_spawn.instantiate()
	#scene.init(projectile)
	Game.get_level_manager().get_current_level().add_object.call_deferred(scene, projectile.global_position)
	if free_on_scene_spawn:
		projectile.queue_free()
