class_name ProjectileData extends Object

## This class contains generic data passed to the constructor of projectiles so
## they do not need a bunch of conditions to check if a weapon object is present.

var added_damage: int
var damage_mod: float
var pierce: int
var projectile_velocity_mod: float
var total_damage_mod: float
var crit_chance: float
var crit_mod: float

func _init(
	added_damage_: int = 0,
	damage_mod_: float = 1.0,
	pierce_: int = 0,
	projectile_velocity_mod_: float = 1.0,
	total_damage_mod_: float = 1.0,
	crit_chance_: float = 0.0,
	crit_mod_: float = 1.0,
) -> void:
	added_damage = added_damage_
	damage_mod = damage_mod_
	pierce = pierce_
	projectile_velocity_mod = projectile_velocity_mod_
	total_damage_mod = total_damage_mod_
	crit_chance = crit_chance_
	crit_mod = crit_mod_
	
static func _from_gun(weapon: GunBase, stats: PlayerStats) -> ProjectileData:
	return ProjectileData.new(
		weapon.added_damage + stats.added_damage + stats.added_damage_gun,
		weapon.damage_mod * stats.damage_mod_gun,
		weapon.added_pierce + stats.added_pierce,
		weapon.projectile_velocity_mod * stats.projectile_velocity_mod,
		stats.damage_mod,
		stats.crit_chance + stats.crit_chance_gun,
		stats.crit_damage_mod + stats.crit_damage_mod_gun,
	)

static func from_weapon(weapon: WeaponBase, stats: PlayerStats) -> ProjectileData:
	match weapon.weapon_type:
		WeaponBase.WeaponType.GUN:
			return _from_gun(weapon as GunBase, stats)
		_:
			return null
