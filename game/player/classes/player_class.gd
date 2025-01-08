@icon("res://game/player/classes/player_class.svg")
class_name PlayerClass extends Resource

## The name of this class
@export var player_class_name: String

## A description of this class
@export var player_class_description: String

## The icon of this class
@export var player_class_icon: Texture2D

## The stats the player should start with
@export var player_stats: PlayerStats

@export var global_ranged_weapon_stats: RangedWeaponStats
@export var global_explosive_weapon_stats: ExplosiveWeaponStats
@export var global_melee_weapon_stats: MeleeWeaponStats

@export var starting_weapons: Array[String]
