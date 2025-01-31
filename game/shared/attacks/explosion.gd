@tool
class_name Explosion extends Area2D

@onready var explosion_sound_effect: AudioStreamPlayer2D = $ExplosionSoundEffect
@onready var explosion_radius: CollisionShape2D = $CollisionShape2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var _attack: Attack

func init(atk: Attack, area_mod: float = 1.0) -> void:
	_attack = atk
	explosion_radius.shape.radius *= area_mod

func _ready() -> void:
	pass
	#var crater = CRATER.instantiate()
	#GameManager.get_game_root().add_child(crater)
	#crater.global_position = global_position
	#crater.scale = Vector2.ONE * (weapon_group.get_explosion_radius()) / 75.0

func _explode() -> void:
	var nearby_targets = get_overlapping_bodies()
	# Randomly pitch the sound effect up/down to add variety.
	explosion_sound_effect.pitch_scale = randf_range(0.8, 1.2)
	animation_player.play("explode")
	#GameManager.explosion_occurred.emit()
	for target in nearby_targets:
		target.take_damage(_attack)


func _on_timer_timeout() -> void:
	_explode()
