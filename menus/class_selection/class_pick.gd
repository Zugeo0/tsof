class_name PlayerClassPick extends Button

@onready var player_class_name: Label = $Name
@onready var player_class_description: Label = $Description
@onready var player_class_icon: TextureRect = $AspectRatioContainer/IconBackdrop/TextureRect

var _player_class: PlayerClass

func set_class(player_class: PlayerClass) -> void:
	player_class_name.text = player_class.player_class_name
	player_class_description.text = player_class.player_class_description
	player_class_icon.texture = player_class.player_class_icon
	_player_class = player_class


func _on_pressed() -> void:
	RunSettings.set_run_class(_player_class)
	SceneManager.load_game()
