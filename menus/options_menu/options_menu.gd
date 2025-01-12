class_name OptionsMenu extends Control

@onready var master_volume_slider: HSlider = $VBoxContainer/MasterVolume/MasterVolumeSlider
@onready var music_volume_slider: HSlider = $VBoxContainer/MusicVolume/MusicVolumeSlider
@onready var sfx_volume_slider: HSlider = $VBoxContainer/SFXVolume/SFXVolumeSlider

signal closed

var settings: SettingsSaveFile

func open() -> void:
	visible = true
	
	settings = SaveManager.settings.duplicate()
	master_volume_slider.value = settings.master_volume
	music_volume_slider.value = settings.music_volume
	sfx_volume_slider.value = settings.sfx_volume
	
	master_volume_slider.grab_focus()

func close() -> void:
	visible = false
	closed.emit()

func _on_back_button_pressed() -> void:
	SaveManager.reset_settings()
	close()

func _on_apply_button_pressed() -> void:
	SaveManager.apply_settings(settings)
	SaveManager.save_settings(settings)


func _on_master_volume_slider_value_changed(value: float) -> void:
	settings.master_volume = value
	SaveManager.preview_settings(settings)


func _on_music_volume_slider_value_changed(value: float) -> void:
	settings.music_volume = value
	SaveManager.preview_settings(settings)


func _on_sfx_volume_slider_value_changed(value: float) -> void:
	settings.music_volume = value
	SaveManager.preview_settings(settings)


func _on_apply_and_exit_button_pressed() -> void:
	SaveManager.apply_settings(settings)
	SaveManager.save_settings(settings)
	close()
