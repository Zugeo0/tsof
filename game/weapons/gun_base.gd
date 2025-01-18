@icon("res://game/weapons/weapon_base.svg")
class_name GunBase extends WeaponBase

@export_category("Weapon Stats")
## A flat amount of added damage dealt by this weapon.
@export var added_damage: int = 0
## A multiplier to damage dealt by this weapon.
@export var damage_mod: float = 1.0
## A multiplier to this weapon's attack speed.
@export var attack_speed_mod: float = 1.0
## A flat amount of added pierce for this weapon.
@export var added_pierce: int = 0
## Extra projectiles per attack.
@export var extra_projectiles: int = 0
## Total attacks per attack trigger.
@export var attacks_per_cycle: int = 1
## A multiplier to the speed of projectiles fired by this weapon.
@export var projectile_velocity_mod: float = 1.0
## The delay between attacks in a single cycle (e.g. burst-fire).
@export var delay_between_attacks: float = 0.25
## The general accuracy of projectiles fired by this weapon.
@export_range(0.0, 360.0, 0.1, "radians_as_degrees") var projectile_spread: float = PI / 4

@export_category("Modifiers")
@export var projectile_type: ProjectileType

@onready var crosshair: Sprite2D = $Crosshair

var _current_target: Enemy = null

## Changes the projectile spawned by this weapon and reevaluates the number of
## projectiles to spawn.
func set_projectile_type(proj_type: ProjectileType) -> void:
	projectile_type = proj_type

func _process(_delta: float) -> void:
	sprite.flip_v = global_transform.x.x < 0
	crosshair.visible = _current_target != null
	
	if _current_target != null:
		crosshair.global_position = _current_target.global_position
		look_at(_current_target.global_position)

func set_target(target: Enemy) -> void:
	_current_target = target
	
func get_target() -> Enemy:
	return _current_target

func total_projectiles() -> int:
	return projectile_type.projectile_count + extra_projectiles
