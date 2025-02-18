extends Node

@export var projectile_type: ProjectileType

## TODO: Add bonus projectile stat scaling
func _spawn_uniform_nodes(at: Vector2, atk: Attack, data: ProjectileData) -> void:
	var proj_count: int = projectile_type.projectile_count
	for i in range(proj_count):
		var proj: Projectile = projectile_type.projectile_scene.instantiate()
		var theta = (2 * PI) * (float(i) / proj_count)
		var dir = Vector2(-sin(theta), cos(theta))
		proj.init(dir, atk.attacker, data)
		proj.rotation = atan2(dir.y, dir.x)
		Game.get_level_manager().get_current_level().add_object(proj, at)
