class_name ProjectileData extends Object

## This class contains generic data passed to the constructor of projectiles so
## they do not need a bunch of conditions to check if a weapon object is present.

var added_damage: int = 0
var damage_mod: float = 1.0
var pierce: int = 0
var projectile_velocity_mod: float = 1.0
var total_damage_mod: float = 1.0
var crit_chance: float = 0.0
var crit_mod: float = 0.0
var knockback: float = 0.0
var area_of_effect_mod: float = 1.0

func _apply_gun(weapon: GunBase, stats: PlayerStats) -> void:
	damage_mod *= stats.damage_mod_gun
	pierce = weapon.added_pierce + stats.added_pierce
	projectile_velocity_mod *= (weapon.projectile_velocity_mod * stats.projectile_velocity_mod)
	crit_chance = stats.crit_chance + weapon.crit_chance_added + stats.crit_chance_gun
	crit_mod = stats.crit_damage_mod + stats.crit_damage_mod_gun_added + weapon.crit_damage_mod_added

func _apply_explosive(weapon: GunBase, stats: PlayerStats) -> void:
	damage_mod *= stats.damage_mod_explosive
	knockback = weapon.knockback * stats.knockback_mod
	area_of_effect_mod = stats.area_of_effect_mod

func _apply_melee(weapon: MeleeBase, stats: PlayerStats) -> void:
	damage_mod *= stats.damage_mod_melee
	crit_chance = stats.crit_chance + weapon.crit_chance_added + stats.crit_chance_melee
	crit_mod = stats.crit_damage_mod + stats.crit_damage_mod_melee_added + weapon.crit_damage_mod_added
	knockback = weapon.knockback * stats.knockback_mod
	area_of_effect_mod = stats.area_of_effect_mod

static func from_weapon(weapon: WeaponBase, stats: PlayerStats) -> ProjectileData:
	var data := ProjectileData.new()
	data.added_damage = weapon.added_damage + stats.added_damage
	data.damage_mod = weapon.damage_mod

	match weapon.weapon_scaling:
		WeaponBase.WeaponScaling.GUN:
			data._apply_gun(weapon as GunBase, stats)
		WeaponBase.WeaponScaling.EXPLOSIVE:
			data._apply_explosive(weapon, stats)
		WeaponBase.WeaponScaling.MELEE:
			data._apply_melee(weapon as MeleeBase, stats)
		_:
			push_error("Weapon of type %s not found" % weapon.weapon_type)
			return null
	return data
