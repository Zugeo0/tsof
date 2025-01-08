class_name MeleeWeapon extends WeaponType

## The mutable stats for the weapon
@export
var stats: MeleeWeaponStats

## The number of times that the weapon inherently attacks
@export_range(1, 100, 1, "or_greater")
var strike_count: int = 1

## The delay between each additional strike of a single attack for the weapon
@export_range(0.1, 10.0, 0.05, "or_greater", "hide_slider", "suffix:seconds")
var strike_delay: float = 0.3

## The type of enemy the weapon targets
@export var target_priority: TargetPriority
