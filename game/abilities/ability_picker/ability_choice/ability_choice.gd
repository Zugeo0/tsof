class_name AbilityChoice extends Button

@onready var title: Label = $HBoxContainer/InfoPanelContainer/InfoPanel/Title
@onready var description: Label = $HBoxContainer/InfoPanelContainer/InfoPanel/Description
@onready var texture_rect: TextureRect = $HBoxContainer/AspectRatioContainer/IconBackdrop/TextureRect
@onready var stats: HBoxContainer = $HBoxContainer/InfoPanelContainer/InfoPanel/Stats

const POSITIVE_EFFECT_TEXT = preload("res://game/abilities/ability_picker/ability_choice/positive_effect_text.tres")
const NEGATIVE_EFFECT_TEXT = preload("res://game/abilities/ability_picker/ability_choice/negative_effect_text.tres")

func display_ability(ability: AbilityInfo) -> void:
	title.text = ability.ability_name
	description.text = ability.ability_description
	texture_rect.texture = ability.icon
	
	for child in stats.get_children():
		child.queue_free()
	
	if ability.positive_effects.size() > 0:
		_add_positive_stats(ability)
	
	if ability.negative_effects.size() > 0:
		_add_negative_stats(ability)

func _add_positive_stats(ability: AbilityInfo) -> void:
	var vbox: VBoxContainer = VBoxContainer.new()
	vbox.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	vbox.alignment = BoxContainer.ALIGNMENT_CENTER
	stats.add_child(vbox)
	
	for stat in ability.positive_effects:
		var label: Label = Label.new()
		label.text = stat
		label.label_settings = POSITIVE_EFFECT_TEXT
		label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		vbox.add_child(label)

func _add_negative_stats(ability: AbilityInfo) -> void:
	var vbox: VBoxContainer = VBoxContainer.new()
	vbox.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	vbox.alignment = BoxContainer.ALIGNMENT_CENTER
	stats.add_child(vbox)
	
	for stat in ability.negative_effects:
		var label: Label = Label.new()
		label.text = stat
		label.label_settings = NEGATIVE_EFFECT_TEXT
		label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		vbox.add_child(label)
