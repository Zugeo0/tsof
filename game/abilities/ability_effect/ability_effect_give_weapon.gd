class_name AbilityEffectGiveWeapon extends AbilityEffect

@export var weapon_id: String

func apply() -> void:
	Game.get_player().get_weapon_manager().add_weapon(weapon_id)

func description() -> AbilityEffectDescription:
	var desc := AbilityEffectDescription.new()
	desc.description = "Gain '%s'" % weapon_id
	desc.effect_type = AbilityEffectDescription.EffectType.POSITIVE
	return desc
