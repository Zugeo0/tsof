extends Ability

func apply_effects() -> void:
	Game.get_player().get_weapon_manager().add_weapon("shotgun")
	queue_free()
