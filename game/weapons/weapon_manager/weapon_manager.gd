@icon("res://game/weapons/weapon_manager/weapon_manager.svg")
class_name WeaponManager extends Node2D

@export var weapon_pool: Array[PackedScene] = []

@onready var weapons: Node2D = $Weapons
@onready var target_range: Area2D = $TargetRange

@export_group("Global Stats")
@export var ranged_weapon_stats: RangedWeaponStats
@export var explosive_weapon_stats: ExplosiveWeaponStats
@export var melee_weapon_stats: MeleeWeaponStats

var _weapons_types: Dictionary = {}

func _ready() -> void:
	for weapon: PackedScene in weapon_pool:
		_weapons_types[weapon.instantiate().weapon_id] = weapon

func add_weapon(id: String) -> void:
	if id not in _weapons_types:
		push_error("Attempting to add invalid weapon: %s" % id)
		return
	
	var weapon_type: WeaponBase = _weapons_types[id].instantiate()
	weapon_type.set_manager(self)
	weapons.add_child(weapon_type)
	#weapon_type.add_weapon(self)

func get_weapon_type(id: String) -> WeaponBase:
	if id not in _weapons_types:
		push_error("Attempting to add invalid weapon: %s" % id)
		return
	
	return _weapons_types[id]

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
