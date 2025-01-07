extends Ability

const GHOST_PELLET = preload("res://game/projectiles/02_ghost_pellet/ghost_pellet.tscn")

func apply_effects() -> void:
	Game.get_player().get_weapon_manager().set_weapon_projectile("shotgun", GHOST_PELLET)
	queue_free()
