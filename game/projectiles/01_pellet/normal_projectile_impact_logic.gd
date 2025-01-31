class_name NormalProjectileImpactLogic extends ProjectileImpactLogic

@export var projectile: Projectile

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	projectile.impacted.connect(_on_impact)

func _on_impact(body: Enemy, atk: Attack) -> void:
	body.take_damage(atk)
	if not projectile.unlimited_pierce and atk.pierce_count < atk.pierce:
		projectile.queue_free()
