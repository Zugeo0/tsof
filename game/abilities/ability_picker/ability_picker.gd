class_name AbilityPicker extends CanvasLayer

const ABILITY_CHOICE = preload("res://game/abilities/ability_picker/ability_choice/ability_choice.tscn")

@onready var ability_list_container: VBoxContainer = $AbilityListContainer
@onready var ability_manager: AbilityManager = %AbilityManager

func open(abilities: Array[AbilityInfo]) -> void:
	PauseManager.pause(self)
	visible = true
	
	for ability_pick in ability_list_container.get_children():
		ability_pick.queue_free()
	
	for ability in abilities:
		var choice: AbilityChoice = ABILITY_CHOICE.instantiate()
		ability_list_container.add_child(choice)
		choice.display_ability(ability)
		choice.pressed.connect(_on_ability_picked.bind(ability))
		choice.grab_focus()
	
	_add_skip_button()

func _add_skip_button() -> void:
	var xp_gain: int = 125
	var button: Button = Button.new()
	button.text = "Skip (+%d XP)" % xp_gain
	button.pressed.connect(_skip_selection.bind(xp_gain))
	button.custom_minimum_size = Vector2(0, 50)
	ability_list_container.add_child(button)

func _on_ability_picked(ability: AbilityInfo) -> void:
	ability_manager.add_ability(ability)
	close()

func _skip_selection(xp_gained: int) -> void:
	Game.get_player().add_xp(xp_gained)
	close()

func close() -> void:
	visible = false
	PauseManager.unpause(self)
	
	for ability_pick in ability_list_container.get_children():
		ability_pick.queue_free()
