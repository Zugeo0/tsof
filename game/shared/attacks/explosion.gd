@tool
class_name Explosion extends Area2D

@onready var explosion_sound_effect: AudioStreamPlayer = $ExplosionSoundEffect
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var timer: Timer = $Timer
@onready var gpu_particles_2d: GPUParticles2D = $GPUParticles2D

signal explode(atk: Attack)

var _attack: Attack
var _area_mod: float

func _ready() -> void:
	collision_shape_2d.shape.radius *= _area_mod
	# Allows the animations' particles to loop in the editor.
	gpu_particles_2d.one_shot = !Engine.is_editor_hint()

func init(atk: Attack, area_mod: float = 1.0) -> void:
	_attack = atk
	_area_mod = area_mod

func _process(_delta: float) -> void:
	if Engine.is_editor_hint():
		if !animation_player.is_playing():
			animation_player.play("explode")

func _on_timer_timeout() -> void:
	explode.emit(_attack)
