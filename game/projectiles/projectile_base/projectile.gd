@icon("res://game/projectiles/projectile_base/projectile.svg")
class_name Projectile extends Area2D

@export var damage: int = 1
@export var added_damage_effectiveness: float = 1.0
@export var pierce: int = 0
@export var speed: float = 1.0
@export var unlimited_pierce: bool = false
@export var face_direction: bool = false

var _direction: Vector2 = Vector2.ZERO
var _data: ProjectileData = null

var _attack: Attack

signal impacted(body: Node2D, attack: Attack, data: ProjectileData)
signal despawned(at: Vector2, atk: Attack, data: ProjectileData)

func init(direction: Vector2, attacker: Node, data: ProjectileData) -> void:
	_direction = direction
	_data = data
	_attack = _calculate_attack(attacker)
	speed *= data.projectile_velocity_mod
	if face_direction:
		look_at(_direction)

func despawn() -> void:
	despawned.emit(global_position, _attack, _data)
	print("proj despawned!")
	queue_free()

func _ready() -> void:
	body_entered.connect(func(body): impacted.emit(body, _attack, _data))

func _physics_process(delta: float) -> void:
	global_position += _direction * speed * delta * 100.0

func _calculate_attack(attacker: Node2D) -> Attack:
	var attack_damage = roundi(
		damage
		+ (_data.added_damage * added_damage_effectiveness)
		* _data.damage_mod
		* _data.total_damage_mod
	)
	var attack := Attack.new()
	attack.attacker = attacker
	attack.damage = attack_damage
	attack.pierce = _data.pierce

	return attack

func get_attack_obj() -> Attack:
	return _attack
