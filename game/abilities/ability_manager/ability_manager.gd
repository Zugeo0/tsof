@icon("res://game/abilities/ability_manager/ability_manager.svg")
class_name AbilityManager extends Node

@export var ability_pool: Array[AbilityInfo]

var available_abilities: int = 0

func add_ability(ability: AbilityInfo) -> void:
	if available_abilities <= 0:
		return
	
	available_abilities -= 1
	
	for effect in ability.ability_effects:
		effect.apply()

func get_random_abilities() -> Array[AbilityInfo]:
	var abilities: Array[AbilityInfo] = []
	for i in range(3):
		abilities.push_back(ability_pool[i])
	
	abilities.shuffle()
	return abilities

func _on_player_levelup() -> void:
	available_abilities += 1
