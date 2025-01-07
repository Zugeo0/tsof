@icon("res://game/weapons/weapon_manager/weapon_manager.svg")
class_name WeaponManager extends Node2D

@onready var equipped_weapons: Node2D = $EquippedWeapons
@onready var target_range: Area2D = $TargetRange

@export var available_weapons: Array[WeaponType]

var _weapons_classes: Dictionary = {}

func _ready() -> void:
	for weapon_type in available_weapons:
		var weapon_scene: WeaponClass = weapon_type.weapon_class.instantiate()
		_weapons_classes[weapon_type.weapon_id] = weapon_scene
		weapon_scene.set_manager(self)

func add_weapon(id: String) -> void:
	if id not in _weapons_classes:
		push_error("Attempting to add invalid weapon: %s" % id)
		return
	
	var weapon_class: WeaponClass = _weapons_classes[id]
	if weapon_class not in equipped_weapons.get_children():
		equipped_weapons.add_child(weapon_class)
	
	weapon_class.add_weapon()

func get_weapon_class(id: String) -> WeaponClass:
	if id not in _weapons_classes:
		push_error("Attempting to add invalid weapon: %s" % id)
		return
	
	return _weapons_classes[id]

func set_weapon_projectile(weapon_id: String, projectile: PackedScene) -> void:
	var weapon_class = get_weapon_class(weapon_id)
	weapon_class.projectile = projectile

func get_closest_enemies() -> Array[Enemy]:
	var enemies: Array[Enemy]
	enemies.assign(target_range.get_overlapping_bodies())
	enemies.sort_custom(_sort_closest)
	return enemies

func _sort_closest(a: Enemy, b: Enemy) -> bool:
	var dist_a = a.global_position.distance_to(global_position)
	var dist_b = b.global_position.distance_to(global_position)
	return dist_a < dist_b
