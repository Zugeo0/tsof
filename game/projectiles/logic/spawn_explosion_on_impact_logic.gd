@tool
class_name SpawnExplosionOnImpactLogic extends Node2D

@export var scene_to_spawn: PackedScene
@export var free_on_scene_spawn: bool = true
@export var spawned_by: Projectile
@export var base_radius: float = 10.0:
	set(value):
		base_radius = value
		if Engine.is_editor_hint():
			queue_redraw()

@export_category("Debug settings")
@export var debug_color: Color = Color.WHITE:
	set(value):
		debug_color = value
		if Engine.is_editor_hint():
			queue_redraw()

func _ready() -> void:
	if Engine.is_editor_hint():
		return

	spawned_by.impacted.connect(_on_impact)

func _draw() -> void:
	if Engine.is_editor_hint():
		draw_circle(position, base_radius, debug_color)

func _on_impact(_body: Node2D, atk: Attack, data: ProjectileData) -> void:
	var scene: Explosion = scene_to_spawn.instantiate()
	scene.init(atk, base_radius, data.area_of_effect_mod)
	Game.get_level_manager().get_current_level().add_object.call_deferred(scene, spawned_by.global_position)
	if free_on_scene_spawn:
		spawned_by.queue_free()
