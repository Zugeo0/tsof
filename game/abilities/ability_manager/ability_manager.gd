@icon("res://game/abilities/ability_manager/ability_manager.svg")
class_name AbilityManager extends Node

const ABILITY_SHOTGUN = preload("res://game/abilities/01_shotgun/ability_shotgun.tres")

@export var ability_pool: Array[AbilityInfo]

# TODO: Remove
func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and event.keycode == KEY_T:
		add_ability(ABILITY_SHOTGUN)

func add_ability(ability: AbilityInfo) -> void:
	var ability_node: Ability = ability.ability_script.new()
	ability_node.apply_effects()

func get_random_abilities() -> Array[AbilityInfo]:
	var abilities: Array[AbilityInfo] = []
	for i in range(3):
		abilities.push_back(ability_pool[i])
	
	abilities.shuffle()
	return abilities