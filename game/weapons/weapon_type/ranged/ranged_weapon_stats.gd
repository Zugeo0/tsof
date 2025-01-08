class_name RangedWeaponStats extends Resource

## A flat amount of bonus damage to all projectiles fired by ranged weapons.
@export_range(0, 10, 1, "or_greater")
var added_projectile_damage: int = 0

## A multiplier to the amount of damage the projectile does
@export_range(0.0, 1.0, 0.01, "or_greater", "suffix:x")
var projectile_damage_multiplier: float = 1.0

## A multiplier to the projectile speed
@export_range(0.0, 1.0, 0.01, "or_greater", "suffix:x")
var projectile_speed_multiplier: float = 1.0

## A flat bonus to the number of projectiles fired by the player's ranged weapons.
@export_range(0, 2, 1, "or_greater")
var extra_projectiles: int = 0

## A flat bonus to the projectile's pierce stat
@export_range(0, 3, 1, "or_greater")
var added_pierce: int = 0

## A multiplier to the attack speed of all ranged weapons.
@export_range(0.5, 3.0, 0.01, "or_greater")
var attack_speed_mod: float = 1.0
