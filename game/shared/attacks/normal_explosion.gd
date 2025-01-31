class_name NormalExplosionLogic extends ExplosionLogic

func _explode(atk: Attack) -> void:
	var nearby_targets = explosion.get_overlapping_bodies()
	# Randomly pitch the sound effect up/down to add variety.
	#GameManager.explosion_occurred.emit()
	_play_sfx()
	_play_animation()
	for target in nearby_targets:
		target.take_damage(atk)

func _play_sfx() -> void:
	explosion.explosion_sound_effect.pitch_scale = randf_range(0.8, 1.2)

func _play_animation() -> void:
	explosion.animation_player.play("explode")
