class_name AbilityEffectIntValue extends AbilityEffectStatValue

@export var value_change: int

func get_inverse() -> AbilityEffectStatValue:
	var inverse: AbilityEffectIntValue = duplicate()
	inverse.value_change = -value_change
	return inverse
