@icon("res://game/projectiles/projectile_base/projectile.svg")
class_name Projectile extends Area2D

@export var damage: int = 1
@export var added_damage_effectiveness: float = 1.0
@export var pierce: int = 0
@export var speed: float = 1.0
@export var unlimited_pierce: bool = false

var _direction: Vector2 = Vector2.ZERO
var _data: ProjectileData = null

var _attack: Attack

func init(direction: Vector2, attacker: Node, data: ProjectileData) -> void:
	_direction = direction
	_data = data
	_attack = _calculate_attack(attacker)
	speed *= data.projectile_velocity_mod

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
	var attack_pierce = pierce + _data.pierce
	var attack_damage = roundi(
		damage
		+ (_data.added_damage * added_damage_effectiveness)
		* _data.damage_mod
		* _data.total_damage_mod
	)
	var attack := Attack.new()
	attack.attacker = attacker
	attack.damage = attack_damage
	attack.pierce = attack_pierce

	return attack

func _create_despawn_timer() -> void:
	var despawn_timer = Timer.new()
	despawn_timer.process_mode = Node.PROCESS_MODE_PAUSABLE
	despawn_timer.wait_time = 5.0
	despawn_timer.timeout.connect(queue_free)
	despawn_timer.one_shot = true
	despawn_timer.autostart = true
	add_child(despawn_timer)
