@icon("res://game/weapons/weapon_base.svg")
class_name OrbitalWeaponBase extends WeaponBase

@export var base_damage: int = 5
@export var added_damage_effectiveness: float = 1.0
@export var base_knockback: int = 5
@onready var collider: Area2D = $Collider

var _logic: OrbitalWeaponLogic = null
var _player_stats: PlayerStats = null
var _player: Player = null

func _ready() -> void:
	_player = Game.get_player()
	_player_stats = _player.player_stats

func set_logic(lgc: OrbitalWeaponLogic) -> void:
	_logic = lgc

func _on_collider_body_entered(body: Enemy) -> void:
	var atk := Attack.new()
	var added_damage_flat: int = _player_stats.added_damage + _player_stats.added_damage_melee
	var damage_mod: float = _player_stats.damage_mod * _player_stats.damage_mod_melee
	atk.damage = base_damage + int(((added_damage_flat) * (damage_mod)) * added_damage_effectiveness)
	var knockback = base_knockback * _player_stats.knockback_mod
	var knockback_vector := _player.global_position.direction_to(body.global_position)
	atk.knockback = knockback_vector * knockback * 100
	body.take_damage(atk)
