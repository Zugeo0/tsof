class_name ProjectileData extends Object

## This class contains generic data passed to the constructor of projectiles so
## they do not need a bunch of conditions to check if a weapon object is present.

var added_damage: int
var damage_mod: float
var pierce: int
var projectile_velocity_mod: float
var total_damage_mod: float

func _init(
	added_damage_: int = 0,
	damage_mod_: float = 1.0,
	pierce_: int = 0,
	projectile_velocity_mod_: float = 1.0,
	total_damage_mod_: float = 1.0
) -> void:
	added_damage = added_damage_
	damage_mod = damage_mod_
	pierce = pierce_
	projectile_velocity_mod = projectile_velocity_mod_
	total_damage_mod = total_damage_mod_
