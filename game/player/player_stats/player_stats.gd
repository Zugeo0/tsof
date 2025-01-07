@icon("res://game/player/player_stats/player_stats.svg")
class_name PlayerStats extends Resource

## The name of this class
@export var player_class_name: String

## A description of this class
@export var player_class_description: String

## The icon of this class
@export var player_class_icon: Texture2D

## The entity's armor (damage reduction)
@export var armor: int = 0

## The entity's current health
@export var health: int = 20

## The amount of damage this entity can take before dying.
@export var max_health: int = 20

## A multiplier to the player's maximum health. Increasing this value should heal the player by the modified amount.
@export var max_health_mod: float = 1.0

## The entity's movement speed.
@export var movement_speed: float = 5.0

## A multiplier to the player's movement speed.
@export var movement_speed_mod: float = 1.0

## The number of seconds where the player is granted damage immunity on taking damage
@export_range(0, 2, 0.05, "or_greater") var invincibility_time: float = 0.1

## A flat amount of health healed by the player every time the regen timer ticks.
@export_range(0, 100, 1, "or_greater") var regen_amount_flat: int = 1

## A percentile amount of health healed by the player every time the regen timer ticks.
@export_range(0.0, 100.0, 0.1) var regen_amount_percentile: float = 0.0

## The chance of the player completely ignoring damage from a single attack. Grants invincibility frames.
@export_range(0.0, 0.75, 0.01) var dodge_chance: float = 0.0

## A multiplier to the entity's regeneration speed. Increasing this value will make the regen tick faster.
@export_range(0.0, 3.0, 0.1) var regen_speed_mod: float = 1.0

## The number of seconds it takes for each regen tick.
@export_range(0.1, 100.0, 0.1, "or_greater") var regen_speed: float = 2.0

## Whether the player can regenerate or not. If false, regen cannot affect the player at all.
@export var can_regen: bool = true

## Do the player's critical strikes deal damage?
@export var crits_deal_damage: bool = true

## A multiplier to experience gained by the player.
@export var experience_gain_mod: float = 1.0

## The absorb range for item drops for the player.
@export var item_absorb_range: float = 55.0

## A multiplier to the player's item drop absorb range. May be changed at runtime.
@export var item_absorb_range_mod: float = 1.0

@export_category("Weapons")

## The entity's attack speed modifier.
@export var attack_speed_mod: float = 1.0

## The weapons the player should start with as ids
@export var starting_weapons: Array[String]

@export_group("Offense - Melee")

## A flat amount of bonus damage to each strike of a melee weapon
@export_range(0, 10, 1, "or_greater") var added_melee_damage: int = 0

## The number of additional attacks triggered every melee attack
@export_range(0, 3, 1, "or_greater") var added_melee_strikes: int = 0

## An additional amount of knockback for melee weapons
@export_range(0, 100, 1, "or_greater") var added_melee_knockback: int = 0

## Affects the length of melee strikes.
@export_range(0.5, 3.0, 0.01, "or_greater") var melee_range_mod: float = 1.0

## A multiplier to the attack speed of all melee weapons.
@export_range(0.5, 3.0, 0.01, "or_greater") var melee_attack_speed_mod: float = 1.0

## A multiplier to all melee weapon knockback.
@export_range(0.0, 3.0, 0.01, "or_greater") var melee_knockback_mod: float = 1.0

@export_group("Offense - Ranged")

## A flat amount of bonus damage to all projectiles fired by ranged weapons.
@export_range(0, 10, 1, "or_greater") var added_gun_damage: int = 0

## A flat bonus to the number of projectiles fired by the player's ranged weapons.
@export_range(0, 2, 1, "or_greater") var extra_projectiles: int = 0

## The number of times a projectile can pass through an entity before despawning (additive with weapon/projectile modifiers).
@export_range(0, 3, 1, "or_greater") var extra_projectile_pierce: int = 0

## The "accuracy" of the player's weapons. Affects bullet velocity (and therefore range)
@export_range(0.5, 3.0, 0.01, "or_greater") var ranged_range_mod: float = 1.0

## Affects the spread of the player's ranged projectiles. A lower value means lower spread.
@export_range(0.0, 2.0, 0.01, "or_greater") var ranged_spread_mod: float = 1.0

## A multiplier to the attack speed of all ranged weapons.
@export_range(0.5, 3.0, 0.01, "or_greater") var ranged_attack_speed_mod: float = 1.0

@export_group("Offense - Explosive")

## A flat bonus to the amount of damage dealt by explosions.
@export_range(0, 10, 1, "or_greater") var added_explosive_damage: int = 0

## A flat addition to explosive weapons' explosion radii.
@export_range(0.0, 100.0, 0.1, "or_greater") var added_explosive_radius: float = 0.0

## A multiplier to the radius of explosions.
@export_range(0.1, 100.0, 0.1, "or_greater") var explosive_radius_mod: float = 1.0

## A multiplier to all damage dealt by explosions.
@export_range(0.5, 2.0, 0.1, "or_greater") var explosive_damage_mod: float = 1.0

@export_group("Offense - General")

## The chance of a single projectile of an attack (NOT the entire attack unless it's melee) getting a critical multiplier.
@export_range(0.0, 1.0, 0.01) var crit_chance: float = 0.0

## A multiplier to a melee attack or a single explosion or projectile's damage.
@export var damage_mod: float = 1.0

## A multiplier to attacks that crit.
@export_range(1.0, 3.0, 0.01) var crit_multiplier: float = 2.0
