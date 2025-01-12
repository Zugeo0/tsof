class_name HealthComponent extends Node

var armor: int = 0
var health: int = 0
var max_health: int = 0

func apply_attack(attack: Attack) -> void:
	var armor_used := armor - attack.pierce
	var applied_damage := attack.damage * _calculate_armor_reduction(armor_used)
	health = max(health - applied_damage, 0)

func _calculate_armor_reduction(armor_value: int) -> float:
	# Some magic formula
	armor_value = max(armor_value + 1, 1)
	var a := 2.0 + log(armor_value)
	var b := 1.0 + armor_value
	return a / b
