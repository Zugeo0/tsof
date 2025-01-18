class_name AbilityEffectStatChange extends AbilityEffect

enum Stat {
	# Player stats
	PLAYER_MAX_HEALTH,
	PLAYER_ARMOR,
	PLAYER_REGEN,
	PLAYER_CRIT_CHANCE,
	PLAYER_MAX_HEALTH_MULTI,
	PLAYER_KNOCKBACK_MULTI,
	PLAYER_MOVE_SPEED_MULTI,
	PLAYER_PICKUP_RANGE_MULTI,
	PLAYER_CAN_REGEN,
}

@export var stat: Stat
@export var value_change: AbilityEffectStatValue

func apply() -> void:
	apply_change(value_change)

func remove() -> void:
	var inverse = value_change.get_inverse()
	apply_change(inverse)

func description() -> AbilityEffectDescription:
	match stat:
		Stat.PLAYER_MAX_HEALTH: return _describe_stat("Max health")
		Stat.PLAYER_ARMOR: return _describe_stat("Armor")
		Stat.PLAYER_REGEN: return _describe_stat("Regen amount")
		Stat.PLAYER_CRIT_CHANCE: return _describe_stat("Crit chance", "%")
		Stat.PLAYER_MAX_HEALTH_MULTI: return _describe_stat("Max health", "%")
		Stat.PLAYER_KNOCKBACK_MULTI: return _describe_stat("Knockback", "%")
		Stat.PLAYER_MOVE_SPEED_MULTI: return _describe_stat("Move speed", "%")
		Stat.PLAYER_PICKUP_RANGE_MULTI: return _describe_stat("Pickup range", "%")
		Stat.PLAYER_CAN_REGEN: return _describe_stat("regen", "%")
		
		_:
			push_error("No description for stat %d", stat)
			return AbilityEffectDescription.new()

func apply_change(value_change: AbilityEffectStatValue) -> void:
	var player: Player = Game.get_player()
	match stat:
		Stat.PLAYER_MAX_HEALTH:
			var value := value_change as AbilityEffectIntValue
			player.player_stats.max_health += value.value_change
			
		Stat.PLAYER_ARMOR:
			var value := value_change as AbilityEffectIntValue
			player.player_stats.armor += value.value_change
			
		Stat.PLAYER_REGEN:
			var value := value_change as AbilityEffectIntValue
			player.player_stats.regen_amt += value.value_change
			
		Stat.PLAYER_CRIT_CHANCE:
			var value := value_change as AbilityEffectFloatValue
			player.player_stats.crit_chance += value.value_change
			
		Stat.PLAYER_MAX_HEALTH_MULTI:
			var value := value_change as AbilityEffectFloatValue
			player.player_stats.max_health_multiplier += value.value_change
			
		Stat.PLAYER_KNOCKBACK_MULTI:
			var value := value_change as AbilityEffectFloatValue
			player.player_stats.knockback_multiplier += value.value_change
			
		Stat.PLAYER_MOVE_SPEED_MULTI:
			var value := value_change as AbilityEffectFloatValue
			player.player_stats.movement_speed += value.value_change
			
		Stat.PLAYER_PICKUP_RANGE_MULTI:
			var value := value_change as AbilityEffectFloatValue
			player.player_stats.absorb_range += value.value_change
			
		Stat.PLAYER_CAN_REGEN:
			# TODO: Do a full re-evaluation
			var value := value_change as AbilityEffectBoolValue
			player.player_stats.can_regen = value.value_change

func _describe_stat(stat_description: String, value_suffix: String = "", invert: bool = false) -> AbilityEffectDescription:
	var desc := AbilityEffectDescription.new()
	
	var is_positive: bool
	
	if value_change is AbilityEffectIntValue:
		if value_change.value_change < 0:
			desc.description = "%s %d%s" % [stat_description, value_change.value_change, value_suffix]
			is_positive = false
		else:
			desc.description = "%s +%d%s" % [stat_description, value_change.value_change, value_suffix]
			is_positive = true
	
	elif value_change is AbilityEffectFloatValue:
		var display_value: float = int(value_change.value_change * 1000) / 10.0
		if value_change.value_change < 0:
			desc.description = "%s %d%s" % [stat_description, display_value, value_suffix]
			is_positive = false
		else:
			desc.description = "%s +%d%s" % [stat_description, display_value, value_suffix]
			is_positive = true
			
	elif value_change is AbilityEffectBoolValue:
		if value_change.value_change:
			desc.description = "Enable %s" % stat_description
			is_positive = true
		else:
			desc.description = "Disable %s" % stat_description
			is_positive = false
	
	if invert:
		is_positive = not is_positive
	
	if is_positive:
		desc.effect_type = AbilityEffectDescription.EffectType.POSITIVE
	else:
		desc.effect_type = AbilityEffectDescription.EffectType.NEGATIVE
	
	return desc
