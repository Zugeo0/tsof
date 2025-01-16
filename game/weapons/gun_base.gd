@icon("res://game/weapons/weapon_type/weapon_type.svg")
class_name GunBase extends WeaponBase

@export_category("Weapon Stats")
## A flat amount of added damage dealt by this weapon.
@export var added_damage: int = 0
## A multiplier to damage dealt by this weapon.
@export var damage_mod: float = 1.0
## A multiplier to this weapon's attack speed.
@export var attack_rate: float = 1.0
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
@export var projectile_spread: Curve

@export_category("Modifiers")
@export var projectile_type: PackedScene

@onready var crosshair: Sprite2D = $Crosshair

var _current_target: Enemy = null
var _projectile_count: int = 0

func _ready() -> void:
	set_projectile_type(projectile_type)

## Changes the projectile spawned by this weapon and reevaluates the number of
## projectiles to spawn.
func set_projectile_type(proj_type: PackedScene) -> void:
	projectile_type = proj_type
	# TODO: I don't really like this, but I see no other better way to get this info for forloops...
	_projectile_count = projectile_type.instantiate().projectile_count

func _process(_delta: float) -> void:
	_reevaluate_target()
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
	return _projectile_count + extra_projectiles

func calculate_spread_vector() -> Vector2:
	var degrees = projectile_spread.sample(randf()) / 2
	
	# Give the projectile a 50% chance of having the angle inverted
	var sign_multiplier = [-1, 1].pick_random()
	var rad = deg_to_rad(degrees)
	
	# Rotate the angle by rad or -rad
	var angle = global_transform.x.rotated(rad * sign_multiplier)
	return angle

func _reevaluate_target() -> void:
	var enemies = _weapon_manager.get_closest_enemies()
	_current_target = enemies[0] if len(enemies) > 0 else null
