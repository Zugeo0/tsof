class_name RangedWeapon extends WeaponType

## The mutable stats for the weapon
@export
var stats: RangedWeaponStats

## The delay between each projectile spawning when burst is enabled
@export_range(0.05, 10.0, 0.01, "or_greater", "suffix:seconds")
var delay_between_attacks: float = 1.0

## The delay between each projectile spawning when burst is enabled
@export_range(0.0, 10.0, 0.01, "or_greater", "suffix:seconds")
var delay_between_burst_projectiles: float = 0.0

## Number of projectiles fired by the weapon
@export_range(1, 25, 1, "or_greater", "suffix:projectiles")
var projectile_count: int = 1

## The min/max angle of which the projectile is curved when the weapon attacks
@export
var projectile_spread: Curve

## The projectile to spawn on attack
@export
var projectile: PackedScene

## Crosshair that the weapon uses
@export
var crosshair: Texture2D

## The type of enemy the weapon targets
@export
var target_priority: TargetPriority
