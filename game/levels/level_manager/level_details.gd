@icon("res://game/levels/level_manager/level_details.svg")
class_name LevelDetails extends Resource

## Level title
@export var title: String = "UNNAMED LEVEL"

## Level duration in seconds
@export var duration: float = 180.0

## Level music
@export var music: AudioStream = null

## Level scene
@export var scene: PackedScene = null

## How far the player camera is zoomed
@export var camera_zoom: float = 1.0
