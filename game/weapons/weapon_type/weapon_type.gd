@icon("res://game/weapons/weapon_type/weapon_type.svg")
class_name WeaponType extends Node2D

enum TargetPriority {
	CLOSEST,
	FARTHEST,
	STRONGEST,
	WEAKEST,
}

enum WeaponCategory {
	RANGED,
	THROWING,
	MELEE,
}

@export_group("Info")

@export var weapon_name: String

@export var weapon_id: String

@export var weapon_category: WeaponCategory

@export var weapon_base: PackedScene

## The sprite used by the weapon
@export var sprite: Texture2D

## The sound-effect played on attack
@export var attack_sfx: AudioStream

var _weapon_manager: WeaponManager

func _process(_delta: float) -> void:
	var enemies = _weapon_manager.get_closest_enemies()
	
	if enemies.size() == 0:
		return
	
	var idx = 0
	for weapon in get_children():
		weapon.set_target(enemies[idx])
		idx = (idx + 1) % enemies.size()

func set_manager(weapon_manager: WeaponManager) -> void:
	_weapon_manager = weapon_manager

func add_weapon() -> void:
	var weapon = weapon_base.instantiate()
	add_child(weapon)
	weapon.init(_weapon_manager, self)
