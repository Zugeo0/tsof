class_name WeaponBase extends Node2D

enum WeaponType {
	GUN,
	THROWN,
	MELEE,
}

@export_category("Config")
@export var weapon_id: String
@export var weapon_name: String
@export var weapon_type: WeaponType

@export_category("Stats")
@export var attack_speed: float = 1.0

var _weapon_manager: WeaponManager = null

func set_manager(weapon_manager: WeaponManager) -> void:
	_weapon_manager = weapon_manager
