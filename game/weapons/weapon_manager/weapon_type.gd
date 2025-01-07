@icon("res://game/weapons/weapon_manager/weapon_type.svg")
class_name WeaponType extends Resource

enum WeaponCategory {
	ALL,
	RANGED,
	THROWING,
	MELEE,
}

## Unique identifier of the weapon
@export var weapon_id: String = ""

## The category of the weapon
@export var category: WeaponCategory = WeaponCategory.ALL

## Scene of the weapon class
@export var weapon_class: PackedScene
