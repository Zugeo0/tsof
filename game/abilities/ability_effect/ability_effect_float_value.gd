class_name AbilityEffectFloatValue extends AbilityEffectStatValue

@export var value_change: float

func get_inverse() -> AbilityEffectStatValue:
	var inverse: AbilityEffectIntValue = duplicate()
	inverse.value_change = -value_change
	return inverse
