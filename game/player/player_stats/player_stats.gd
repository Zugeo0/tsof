@icon("res://game/player/player_stats/player_stats.svg")
class_name PlayerStats extends Resource

## The multipliers of the player's weapon damage. Measured in percentage
@export_group("Offense")
@export_subgroup("Damage multiplier")
@export_range(0.01, 1.0, 0.01, "or_greater", "suffix:x")
var damage_mod: float = 1.0
@export_range(0.01, 1.0, 0.01, "or_greater", "suffix:x")
var damage_mod_gun: float = 1.0
@export_range(0.01, 1.0, 0.01, "or_greater", "suffix:x")
var damage_mod_melee: float = 1.0
@export_range(0.01, 1.0, 0.01, "or_greater", "suffix:x")
var damage_mod_explosive: float = 1.0

## Flat added damage to the player's weapons.
@export_subgroup("Added damage")
@export
var added_damage: int = 0
@export
var added_damage_gun: int = 0
@export
var added_damage_melee: int = 0
@export
var added_damage_explosive: int = 0

## The chance of a critical hit occurring. Measured in percentage
@export_subgroup("Critical Chance")
@export_range(0.0, 1.0, 0.01, "suffix:x")
var crit_chance: float = 0.0
@export_range(0.0, 1.0, 0.01, "suffix:x")
var crit_chance_gun: float = 0.0
@export_range(0.0, 1.0, 0.01, "suffix:x")
var crit_chance_melee: float = 0.0

## The damage multiplier for critical strikes. Measured in percentage.
@export_subgroup("Critical Multiplier")
@export_range(0.0, 1.0, 0.01, "suffix:x")
var crit_damage_mod: float = 2.0
# The weapon crit damage modifiers are additive with the global crit damage mod.
@export_range(0.0, 1.0, 0.01, "suffix:x")
var crit_damage_mod_gun_added: float = 0.0
@export_range(0.0, 1.0, 0.01, "suffix:x")
var crit_damage_mod_melee_added: float = 0.0

## The speed multipliers of the player's weapons. Measured in percentage
@export_subgroup("Attack speed")
@export_range(0.05, 1.0, 0.01, "or_greater", "suffix:x")
var attack_speed_mod: float = 1.0
@export_range(0.05, 1.0, 0.01, "or_greater", "suffix:x")
var attack_speed_mod_gun: float = 1.0
@export_range(0.05, 1.0, 0.01, "or_greater", "suffix:x")
var attack_speed_mod_melee: float = 1.0
@export_range(0.05, 1.0, 0.01, "or_greater", "suffix:x")
var attack_speed_mod_explosive: float = 1.0

## The multipliers for the knockback of the player's weapons
@export_subgroup("Knockback")
@export_range(0.0, 1.0, 0.01, "or_greater", "suffix:x")
var knockback_mod: float = 1.0

@export_group("Defense")
## The amount of health the player can have without multipliers
@export_range(0, 100, 1, "or_greater", "suffix:hp")
var max_health: int = 100
## The amount the max health is multiplied by. Measured in percentage.
## If it's 0, then the player has 1 health.
@export_range(0.0, 1.0, 0.01, "or_greater", "suffix:x")
var max_health_mod: float = 1.0
## The amount of armor the player has. This reduces incoming damage
## depending on the enemies pierce amount
@export_range(1, 100, 1, "or_greater", "suffix:armor")
var armor: int = 1
## How quickly the player regains health measured in seconds
@export_range(0.0, 10.0, 0.05, "or_greater", "hide_slider", "suffix:seconds")
var regen_speed: float = 1.0

@export_group("Toggles")
## Specifies whether the player can regenerate health using the regen stat
@export
var can_regen: bool = true
## Specifies whether the player can dodge attacks based on the dodge chance stat
@export
var can_dodge: bool = true

@export_group("Misc.")
@export_range(0.0, 1.0, 0.01, "or_greater")
var movement_speed: float = 80
@export_range(0.0, 1.0, 0.01, "or_greater", "suffix:x")
var movement_speed_mod: float = 1.0
## A multiplier to the player's item absorb radius. Measured in percentage
@export_range(0.25, 1.0, 0.01, "or_greater", "suffix:x")
var absorb_range_mod: float = 1.0
## A multiplier to AoE effects created by the player, including explosions.
@export_range(0.01, 1.0, 0.01, "or_greater", "suffix:x")
var area_of_effect_mod: float = 1.0
## The number of additional melee strikes the player has per melee attack cycle
@export
var melee_multistrike: int = 0
@export
var added_pierce: int = 0
@export
var extra_projectiles: int = 0
@export
var projectile_velocity_mod: float = 1.0
