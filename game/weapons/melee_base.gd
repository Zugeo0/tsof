@icon("res://game/weapons/weapon_base.svg")
class_name MeleeBase extends WeaponBase

@export_category("Weapon Stats")
## A flat amount of added damage dealt by this weapon.
@export var added_damage: int = 0
## A multiplier to damage dealt by this weapon.
@export var damage_mod: float = 1.0
## A flat addition to crit chance for attacks made by this weapon
@export var crit_chance_added: float = 0.0
## A flat addition to the crit multiplier for attacks made by this weapon.
@export var crit_damage_mod_added: float = 0.0
## A multiplier to this weapon's attack speed.
@export var attack_speed_mod: float = 1.0
## Total attacks per attack trigger.
@export var attacks_per_cycle: int = 1
## The delay between attacks in a single cycle (e.g. multistrike).
@export var delay_between_attacks: float = 0.25
## The amount of knockback this weapon applies to enemies on hit.
@export var knockback: int = 0

@onready var crosshair: Sprite2D = $Crosshair

@onready var sprite: Sprite2D = $WeaponPivot/Sprite

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
