@tool
class_name GunBase extends WeaponBase

@export_category("Weapon Stats")
@export var added_damage: int = 0
@export var damage_mod: float = 1.0
@export var attack_rate: float = 1.0
@export var added_pierce: int = 0
## Projectiles per attack
@export var projectiles: int = 1
## Total attacks per attack trigger
@export var attacks_per_cycle: int = 1
@export var projectile_velocity_mod: float = 1.0
@export var delay_between_attacks: float = 0.25
@export var projectile_spread: Curve

@export_category("Modifiers")
@export var projectile_type: PackedScene

@onready var crosshair: Sprite2D = $Crosshair
@onready var sprite: Sprite2D = $Sprite

var _current_target: Enemy = null

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
	# TODO: Add group scaling for proj
	return projectiles

func calculate_spread_vector() -> Vector2:
	var degrees = projectile_spread.sample(randf()) / 2
	
	# Give the projectile a 50% chance of having the angle inverted
	var sign_multiplier = [-1, 1].pick_random()
	var rad = deg_to_rad(degrees)
	
	# Rotate the angle by rad or -rad
	var angle = global_transform.x.rotated(rad * sign_multiplier)
	return angle
