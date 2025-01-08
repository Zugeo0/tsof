@icon("res://game/player/player_stats/player_stats.svg")
class_name PlayerStats extends Resource

## The amount of health the player can have without multipliers
@export_range(0, 100, 1, "or_greater", "suffix:hp")
var max_health: int = 100

## The amount the max health is multiplied by. Measured in percentage.
## If it's 0, then the player has 1 health.
@export_range(0.0, 1.0, 0.01, "or_greater", "suffix:x")
var max_health_multiplier: float = 1.0

## The amount of armor the player has. This reduces incoming damage
## depending on the enemies pierce amount
@export_range(1, 100, 1, "or_greater", "suffix:armor")
var armor: int = 1

## How quickly the player regains health measured in seconds
@export_range(0.0, 10.0, 0.05, "or_greater", "hide_slider", "suffix:seconds")
var regen_speed: float = 1.0

## The chance of a critical hit occurring. Measured in percentage
@export_range(0.0, 1.0, 0.01, "suffix:x")
var crit_chance: float = 0.05

## How quickly the player moves. Measured in percentage
@export_range(0.0, 1.0, 0.01, "or_greater", "suffix:x")
var movement_speed: float = 1.0

## Specifies how far away the player can absorb pickups. Measured in percentage
@export_range(0.25, 1.0, 0.01, "or_greater", "suffix:x")
var absorb_range: float = 1.0

## The global speed multiplier of the player's weapons. Measured in percentage
@export_range(0.05, 1.0, 0.01, "or_greater", "suffix:x")
var attack_speed: float = 1.0

## The global multiplier of the player's weapons damage. Measured in percentage
@export_range(0.01, 1.0, 0.01, "or_greater", "suffix:x")
var attack_damage_multiplier: float = 1.0

## Specifies whether the player can regenerate health using the regen stat
@export
var can_regen: bool = true

## The global multiplier for the knockback of the player's weapons
@export_range(0.0, 1.0, 0.01, "or_greater", "suffix:x")
var knockback_multiplier: float = 1.0
