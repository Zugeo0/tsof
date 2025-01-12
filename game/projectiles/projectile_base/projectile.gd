@icon("res://game/projectiles/projectile_base/projectile.svg")
class_name Projectile extends Area2D

@export var damage: int = 1
@export var pierce: int = 0
@export var speed: float = 1.0
@export var unlimited_pierce: bool = false

var _direction: Vector2 = Vector2.ZERO
var _target: Node = null
var _stats: Array[RangedWeaponStats] = []

var _attack: Attack

func init(direction: Vector2, attacker: Node, target: Node, ranged_stats: Array[RangedWeaponStats] = []) -> void:
	_direction = direction
	_target = target
	_stats = ranged_stats
	_attack = _calculate_attack(attacker)
	
	if _stats != null:
		for stats in _stats:
			speed *= stats.projectile_speed_multiplier

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
	
	if _stats != null:
		for stats in _stats:
			attack.damage += stats.added_projectile_damage
			attack.pierce += stats.added_pierce
		
		for stats in _stats:
			attack.damage = floor(float(attack.damage) * stats.projectile_damage_multiplier)
	
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
