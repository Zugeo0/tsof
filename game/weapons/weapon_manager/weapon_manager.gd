@icon("res://game/weapons/weapon_manager/weapon_manager.svg")
class_name WeaponManager extends Node2D

## The weapons that are available to the player.
## Key = the internal string id of the weapon.
## Value = the PackedScene that instantiates to said weapon.
@export var weapon_pool: Dictionary

@export_group("Global Stats")
@export var ranged_weapon_stats: RangedWeaponStats
@export var explosive_weapon_stats: ExplosiveWeaponStats
@export var melee_weapon_stats: MeleeWeaponStats

@export_group("Config")
@export var max_weapons: int

@onready var weapons: Node2D = $Weapons
@onready var target_range: Area2D = $TargetRange

func add_weapon(id: String) -> void:
	if id not in weapon_pool.keys():
		push_error("Attempting to add invalid weapon: %s" % id)
		return

	if !can_add_weapon():
		push_error("Attempting to exceed the weapon cap with weapon: %s" % id)
		return
	
	var weapon_type: WeaponBase = weapon_pool[id].instantiate()
	weapon_type.set_manager(self)
	weapons.add_child(weapon_type)
	
func can_add_weapon() -> bool:
	return weapons.get_child_count() < max_weapons

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

func get_closest_enemies() -> Array[Enemy]:
	var enemies: Array[Enemy]
	enemies.assign(target_range.get_overlapping_bodies())
	enemies.sort_custom(_sort_closest)
	return enemies

func _sort_closest(a: Enemy, b: Enemy) -> bool:
	var dist_a = a.global_position.distance_to(global_position)
	var dist_b = b.global_position.distance_to(global_position)
	return dist_a < dist_b
