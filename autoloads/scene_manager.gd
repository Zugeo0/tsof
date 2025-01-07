extends Node

var scene_to_load: String

const LOADING_SCREEN = preload("res://menus/loading_screen/loading_screen.tscn")

const MENU_SCENE_PATH = "res://menus/main_menu/main_menu.tscn"
const GAME_SCENE_PATH = "res://game/game.tscn"

func load_main_menu() -> void:
	load_scene(MENU_SCENE_PATH)

func load_game() -> void:
	MusicManager.stop_immediate()
	load_scene(GAME_SCENE_PATH)

func quit_game() -> void:
	get_tree().quit()

func load_scene(path: String) -> void:
	scene_to_load = path
	PauseManager.reset_pause()
	get_tree().change_scene_to_packed(LOADING_SCREEN)
