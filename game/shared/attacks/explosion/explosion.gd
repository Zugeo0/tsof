@tool
class_name Explosion extends Area2D

@onready var explosion_sound_effect: AudioStreamPlayer = $ExplosionSoundEffect
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var timer: Timer = $Timer
@onready var gpu_particles_2d: GPUParticles2D = $GPUParticles2D

signal explode(atk: Attack, radius: float)

var _attack: Attack
var _base_radius: float
var _radius_mod: float

func _ready() -> void:
	collision_shape_2d.shape.radius = _base_radius * _radius_mod
	# Allows the animations' particles to loop in the editor.
	gpu_particles_2d.one_shot = !Engine.is_editor_hint()

func init(atk: Attack, base_radius: float = 10.0, radius_mod: float = 1.0) -> void:
	_attack = atk
	_base_radius = base_radius
	_radius_mod = radius_mod

func _process(_delta: float) -> void:
	if Engine.is_editor_hint():
		if !animation_player.is_playing():
			animation_player.play("explode")

func _on_timer_timeout() -> void:
	explode.emit(_attack, _radius_mod)
