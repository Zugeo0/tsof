class_name PauseMenu extends CanvasLayer

@onready var options_button: Button = $MenuButtons/Options
@onready var options_menu: OptionsMenu = $OptionsMenu
@onready var menu_buttons: VBoxContainer = $MenuButtons

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		toggle()

func toggle() -> void:
	visible = not visible
	PauseManager.set_pause(self, visible)

func unpause() -> void:
	visible = false
	PauseManager.unpause(self)


func _on_resume_pressed() -> void:
	unpause()


func _on_quit_to_menu_pressed() -> void:
	SceneManager.load_main_menu()


func _on_reset_run_pressed() -> void:
	SceneManager.load_game()


func _on_options_pressed() -> void:
	menu_buttons.visible = false
	options_menu.open()


func _on_options_menu_closed() -> void:
	menu_buttons.visible = true
	options_button.grab_focus()
