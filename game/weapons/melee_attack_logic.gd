class_name MeleeAttackLogic extends Node2D

## This class contains logic for skills used by melee weapons.

## The skill triggered by this weapon. This is an export to avoid issues with
## $PathToNode, as the skill scenes may not share a uniform name.
## Ensure that the scene associated with this property is a part of the
## weapon's scene tree, as it is NOT programmatically instantiated.
@export var skill: MeleeSkillBase

@onready var melee_base: MeleeBase = $".."
@onready var attack_cycle_timer: Timer = $AttackCycleTimer
@onready var attack_animation: AnimationPlayer = $AttackAnimation

var _can_attack: bool = false
var _player: Player = null
var _player_stats: PlayerStats = null

func _ready() -> void:
	_player = Game.get_player()
	_player_stats = _player.player_stats
	skill.cooldown_timer.timeout.connect(_on_cooldown_timer_timeout)
	_start_skill_cooldown()

func _process(_delta: float) -> void:
	if _should_attack():
		_attack()

## Performs a single attack cycle, which may consist of multiple individual attacks.
func _attack() -> void:
	_can_attack = false
	var atk_count := melee_base.attacks_per_cycle + _player_stats.melee_multistrike
	## TODO: Make this a little less gross. It's functional, but could be nicer.
	for i in range(atk_count):
		attack_animation.queue("Slam")
	attack_animation.queue("RESET")
	for i in range(atk_count):
		var atk = _get_attack_obj()
		skill.activate(atk, _player.global_position, int(melee_base.knockback * _player_stats.knockback_mod))
		if i != atk_count - 1:
			attack_cycle_timer.start(melee_base.delay_between_attacks)
			await attack_cycle_timer.timeout
	_start_skill_cooldown()

## Starts the weapon's associated skill's cooldown.
func _start_skill_cooldown() -> void:
	skill.start_cooldown(melee_base.attack_speed * melee_base.attack_speed_mod)

## Allow this melee weapon to attack when the skill has cooled down.
func _on_cooldown_timer_timeout() -> void:
	_can_attack = true

## Creates an instance of Attack for this weapon.
## TODO: Make changes related to things such as knockback.
func _get_attack_obj() -> Attack:
	var atk = Attack.new()
	var added_damage = _player_stats.added_damage \
		+ _player_stats.added_damage_melee \
		+ melee_base.added_damage
	atk.damage = skill.base_damage + int(added_damage * skill.added_damage_effectiveness)
	return atk

## Returns true if there are enemies in the skill's area of effect and the skill
## has cooled down.
func _should_attack() -> bool:
	return skill.has_targets() and _can_attack
