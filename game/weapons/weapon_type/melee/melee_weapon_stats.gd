class_name MeleeWeaponStats extends Resource

## The number of times that the weapon inherently attacks
@export
var added_melee_strike_count: int = 0

## The delay between each additional strike of a single attack for a melee weapon
@export_range(0.0, 1.0, 0.01, "or_greater")
var melee_strike_delay_multiplier: float = 1.0
