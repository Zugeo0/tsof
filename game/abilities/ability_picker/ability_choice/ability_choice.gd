class_name AbilityChoice extends Button

@onready var title: Label = $HBoxContainer/InfoPanelContainer/InfoPanel/Title
@onready var description: Label = $HBoxContainer/InfoPanelContainer/InfoPanel/Description
@onready var texture_rect: TextureRect = $HBoxContainer/AspectRatioContainer/IconBackdrop/TextureRect
@onready var stats: HBoxContainer = $HBoxContainer/InfoPanelContainer/InfoPanel/Stats

const POSITIVE_EFFECT_TEXT = preload("res://game/abilities/ability_picker/ability_choice/positive_effect_text.tres")
const NEGATIVE_EFFECT_TEXT = preload("res://game/abilities/ability_picker/ability_choice/negative_effect_text.tres")

var positive_ability_container: VBoxContainer
var negative_ability_container: VBoxContainer

func display_ability(ability: AbilityInfo) -> void:
	title.text = ability.ability_name
	description.text = ability.ability_description
	texture_rect.texture = ability.icon
	
	positive_ability_container = null
	negative_ability_container = null
	
	for child in stats.get_children():
		child.queue_free()
	
	for effect in ability.ability_effects:
		var effect_description := effect.description()
		match effect_description.effect_type:
			AbilityEffectDescription.EffectType.POSITIVE:
				_add_positive_stats(effect_description.description)
			AbilityEffectDescription.EffectType.NEGATIVE:
				_add_negative_stats(effect_description.description)

func _add_positive_stats(stat: String) -> void:
	if positive_ability_container == null:
		positive_ability_container = VBoxContainer.new()
		positive_ability_container.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		positive_ability_container.alignment = BoxContainer.ALIGNMENT_CENTER
		stats.add_child(positive_ability_container)
	
	var label: Label = Label.new()
	label.text = stat
	label.label_settings = POSITIVE_EFFECT_TEXT
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	positive_ability_container.add_child(label)

func _add_negative_stats(stat: String) -> void:
	if negative_ability_container == null:
		negative_ability_container = VBoxContainer.new()
		negative_ability_container.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		negative_ability_container.alignment = BoxContainer.ALIGNMENT_CENTER
		stats.add_child(negative_ability_container)
	
	var label: Label = Label.new()
	label.text = stat
	label.label_settings = NEGATIVE_EFFECT_TEXT
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	negative_ability_container.add_child(label)
