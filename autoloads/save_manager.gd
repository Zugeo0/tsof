extends Node

const SETTINGS_PATH := "user://settings.tres"

var settings: SettingsSaveFile

func _init() -> void:
	if FileAccess.file_exists(SETTINGS_PATH):
		settings = load_settings()
	else:
		settings = SettingsSaveFile.new()
	
	apply_settings(settings)

func save_settings(settings_to_save: SettingsSaveFile) -> void:
	print(settings_to_save.master_volume)
	ResourceSaver.save(settings_to_save, SETTINGS_PATH)

func load_settings() -> SettingsSaveFile:
	return load(SETTINGS_PATH)

func reset_settings() -> void:
	preview_settings(settings)

func apply_settings(new_settings: SettingsSaveFile) -> void:
	settings = new_settings.duplicate()
	preview_settings(new_settings)

func preview_settings(new_settings: SettingsSaveFile) -> void:
	var master_bus = AudioServer.get_bus_index("Master")
	var music_bus = AudioServer.get_bus_index("Music")
	var sfx_bus = AudioServer.get_bus_index("Effects")
	
	AudioServer.set_bus_volume_db(master_bus, linear_to_db(new_settings.master_volume))
	AudioServer.set_bus_volume_db(music_bus, linear_to_db(new_settings.music_volume))
	AudioServer.set_bus_volume_db(sfx_bus, linear_to_db(new_settings.sfx_volume))
