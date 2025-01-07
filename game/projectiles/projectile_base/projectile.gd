@icon("res://game/projectiles/projectile_base/projectile.svg")
class_name Projectile extends Area2D

@export var damage: int = 1
@export var pierce: int = 0
@export var speed: float = 1.0
@export var unlimited_pierce: bool = false

var _direction: Vector2 = Vector2.ZERO
var _caster: Node = null
var _target: Node = null

func init(direction: Vector2, caster: Node, target: Node) -> void:
	_direction = direction
	_caster = caster
	_target = target

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	var despawn_timer = Timer.new()
	despawn_timer.process_mode = Node.PROCESS_MODE_PAUSABLE
	despawn_timer.wait_time = 5.0
	despawn_timer.timeout.connect(queue_free)
	despawn_timer.one_shot = true
	despawn_timer.autostart = true
	add_child(despawn_timer)

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		pierce = body.take_damage(_caster, damage, pierce)
	
	if not unlimited_pierce and pierce <= 0:
		queue_free()

func _physics_process(delta: float) -> void:
	global_position += _direction * speed * delta * 100.0
