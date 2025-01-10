class_name LevelUpPrompt extends Button

@onready var ability_picker: AbilityPicker = %AbilityPicker
@onready var ability_manager: AbilityManager = %AbilityManager
@onready var label: Label = $Label

func _process(_delta: float) -> void:
	visible = ability_manager.available_abilities > 0
	
	label.text = "%d level up(s) available" % ability_manager.available_abilities
	if Input.is_action_just_pressed("open_levelup_menu") and ability_manager.available_abilities > 0:
		_open_ability_picker()


func _on_pressed() -> void:
	_open_ability_picker()


func _open_ability_picker() -> void:
	var abilities = ability_manager.get_random_abilities()
	ability_picker.open(abilities)
