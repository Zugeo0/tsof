@icon("res://game/weapons/weapon_manager/weapon_manager.svg")
class_name WeaponManager extends Node2D

## The weapons that are available to the player.
## Key = the internal string id of the weapon.
## Value = the PackedScene that instantiates to said weapon.
@export var weapon_pool: Dictionary

@export_group("Config")
@export var max_weapons: int

var _weapons: Array[WeaponBase]

@onready var target_range: Area2D = $TargetRange
@onready var target_closest: Node2D = $TargetClosest
@onready var target_farthest: Node2D = $TargetFarthest
@onready var target_nothing: Node2D = $TargetNothing

func add_weapon(id: String) -> void:
	if id not in weapon_pool.keys():
		push_error("Attempting to add invalid weapon: %s" % id)
		return

	if !can_add_weapon():
		push_error("Attempting to exceed the weapon cap with weapon: %s" % id)
		return
	
	var weapon_type: WeaponBase = weapon_pool[id].instantiate()
	weapon_type.set_manager(self)
	_weapons.push_back(weapon_type)
	match weapon_type.target_priority:
		WeaponBase.TargetPriority.CLOSEST:
			target_closest.add_child(weapon_type)
		WeaponBase.TargetPriority.FARTHEST:
			target_farthest.add_child(weapon_type)
		WeaponBase.TargetPriority.NOTHING:
			target_nothing.add_child(weapon_type)
	
func can_add_weapon() -> bool:
	return len(_weapons) < max_weapons

func get_weapon_type(id: String) -> WeaponBase:
	if id not in weapon_pool.keys():
		push_error("Attempting to add invalid weapon: %s" % id)
		return
	
	return weapon_pool[id]

func set_weapon_projectile(weapon_id: String, projectile: PackedScene) -> void:
	var weapon_type = get_weapon_type(weapon_id)
	
	if weapon_type == null:
		return
	
	weapon_type.projectile = projectile
