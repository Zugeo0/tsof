class_name NormalExplosionLogic extends Node2D

@export var explosion: Explosion
@export var crater_sprite: Texture2D

func _ready() -> void:
	explosion.explode.connect(_explode)

func _explode(atk: Attack, explosion_scale: float = 1.0) -> void:
	var nearby_targets = explosion.get_overlapping_bodies()
	# Randomly pitch the sound effect up/down to add variety.
	#GameManager.explosion_occurred.emit()
	_spawn_crater(explosion_scale)
	_pitch_sfx()
	_play_animation()
	for target in nearby_targets:
		target.take_damage(atk)

func _pitch_sfx() -> void:
	explosion.explosion_sound_effect.pitch_scale = randf_range(0.8, 1.2)

func _play_animation() -> void:
	explosion.animation_player.play("explode")

func _spawn_crater(explosion_scale: float) -> void:
	var crater := Sprite2D.new()
	crater.texture = crater_sprite
	crater.scale = Vector2.ONE * explosion_scale
	print(crater)
	Game.get_level_manager().get_current_level().add_object.call_deferred(crater, explosion.global_position)
