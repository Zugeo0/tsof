extends TextureRect

const MAIN_MENU_MUSIC = preload("res://menus/main_menu/survival-metal-with-solo-109315.mp3")

@onready var start_game: Button = $MainButtons/StartGame
@onready var class_selection: PlayerClassSelection = $ClassSelection
@onready var main_buttons: VBoxContainer = $MainButtons

func _ready() -> void:
	MusicManager.start_immediate(MAIN_MENU_MUSIC)
	start_game.grab_focus()


func _on_start_game_pressed() -> void:
	class_selection.show_selection()
	main_buttons.visible = false


func _on_options_pressed() -> void:
	pass # Replace with function body.


func _on_controls_pressed() -> void:
	pass # Replace with function body.


func _on_quit_pressed() -> void:
	SceneManager.quit_game()


func _on_class_selection_back_pressed() -> void:
	class_selection.hide_selection()
	main_buttons.visible = true
	start_game.grab_focus()
