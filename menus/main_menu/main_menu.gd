extends TextureRect

const MAIN_MENU_MUSIC = preload("res://menus/main_menu/survival-metal-with-solo-109315.mp3")

@onready var start_game_button: Button = $MainButtons/StartGame
@onready var options_button: Button = $MainButtons/Options
@onready var main_buttons: VBoxContainer = $MainButtons
@onready var class_selection: PlayerClassSelection = $ClassSelection
@onready var options_menu: OptionsMenu = $OptionsMenu

func _ready() -> void:
	MusicManager.start_immediate(MAIN_MENU_MUSIC)
	start_game_button.grab_focus()


func _on_start_game_pressed() -> void:
	class_selection.show_selection()
	main_buttons.visible = false


func _on_options_pressed() -> void:
	main_buttons.visible = false
	options_menu.open()


func _on_controls_pressed() -> void:
	pass # Replace with function body.


func _on_quit_pressed() -> void:
	SceneManager.quit_game()


func _on_class_selection_back_pressed() -> void:
	class_selection.hide_selection()
	main_buttons.visible = true
	start_game_button.grab_focus()


func _on_options_menu_closed() -> void:
	main_buttons.visible = true
	options_button.grab_focus()
