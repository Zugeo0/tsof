class_name AbilityEffectBoolValue extends AbilityEffectStatValue

@export var value_change: bool

func get_inverse() -> AbilityEffectStatValue:
	var inverse: AbilityEffectIntValue = duplicate()
	inverse.value_change = not value_change
	return inverse
