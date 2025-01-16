@icon("res://game/projectiles/projectile_base/projectile.svg")
class_name Projectile extends Area2D

@export var damage: int = 1
@export var added_damage_effectiveness: float = 1.0
@export var pierce: int = 0
@export var speed: float = 1.0
@export var unlimited_pierce: bool = false

var _direction: Vector2 = Vector2.ZERO
var _target: Node = null
var _gun_base: GunBase = null

var _attack: Attack

func init(direction: Vector2, attacker: Node, target: Node, gun_base: GunBase = null) -> void:
	_direction = direction
	_target = target
	_gun_base = gun_base
	_attack = _calculate_attack(attacker)
	if _gun_base != null:
		speed *= _gun_base.projectile_velocity_mod

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	_create_despawn_timer()

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		body.take_damage(_attack)

	if not unlimited_pierce and _attack.pierce_count >= _attack.pierce:
		queue_free()

func _physics_process(delta: float) -> void:
	global_position += _direction * speed * delta * 100.0

func _calculate_attack(attacker: Node2D) -> Attack:
	var attack := Attack.new()
	attack.damage = damage
	attack.pierce = pierce
	attack.attacker = attacker

	if _gun_base:
		attack.pierce += _gun_base.added_pierce
		attack.damage = roundi(damage + (_gun_base.added_damage * added_damage_effectiveness) * _gun_base.damage_mod)

	if attacker is Player:
		attack.damage *= attacker.player_stats.attack_damage_multiplier

	return attack

func _create_despawn_timer() -> void:
	var despawn_timer = Timer.new()
	despawn_timer.process_mode = Node.PROCESS_MODE_PAUSABLE
	despawn_timer.wait_time = 5.0
	despawn_timer.timeout.connect(queue_free)
	despawn_timer.one_shot = true
	despawn_timer.autostart = true
	add_child(despawn_timer)
