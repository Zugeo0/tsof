@icon("res://game/abilities/ability_manager/ability_info.svg")
class_name AbilityInfo extends Resource

enum Rarity {
	COMMON,
	UNCOMMON,
	RARE,
	CORRUPTED,
}

enum AbilityType {
	PASSIVE,
	CORRUPTED,
	WEAPON,
}

@export var ability_name: String
@export var ability_description: String
@export var ability_effects: Array[AbilityEffect]

@export var type: AbilityType
@export var max_amount: int
@export var rarity: Rarity = Rarity.COMMON

@export var icon: Texture2D

@export_group("Unlock Conditions")

## If above 0, then this ability will always be present at the selected level
@export var guaranteed_at: int = 0
## If above 0, then this ability will not show up until a certain level. Can
## be paired up with guarenteed_at to have it only show up at that level
@export var required_level: int = 0

@export var incompatabilities: Array[AbilityInfo]
@export var requirements: Array[AbilityInfo]
