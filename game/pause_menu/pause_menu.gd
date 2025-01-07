class_name PauseMenu extends CanvasLayer

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
