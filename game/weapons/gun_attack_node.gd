class_name GunProjectileSpawner extends Node2D

@onready var attack_timer: Timer = $AttackTimer
@onready var gun_base: GunBase = $".."
@onready var bullet_spawn_position: Marker2D = $BulletSpawnPosition
@onready var attack_sfx: AudioStreamPlayer2D = $AttackSFX

var _can_attack: bool = false

func _ready() -> void:
	attack_timer.timeout.connect(func(): _can_attack = true)
	Game.get_player().frozen.connect(func(): attack_timer.paused = true)
	Game.get_player().unfrozen.connect(func(): attack_timer.paused = false)

func _process(_delta: float) -> void:
	if _can_attack:
		_attack()

func _reset_attack_timer() -> void:
	attack_timer.wait_time = gun_base.attack_rate
	attack_timer.start()

func _attack() -> void:
	var target = gun_base.get_target()
	if true or target != null:
		_can_attack = false
		for attack in gun_base.attacks_per_cycle:
			for projectile in gun_base.total_projectiles():
				var proj: Projectile = gun_base.projectile_type.instantiate()
				var dir = gun_base.calculate_spread_vector()
				proj.init(dir, Game.get_player(), target, gun_base)
				proj.top_level = true
				proj.global_position = bullet_spawn_position.global_position
				add_child(proj)
				_play_attack_sfx()
		print("Attacked!")
		attack_timer.start()

func _play_attack_sfx() -> void:
	# Randomly pitch the sound effect up/down to add variety.
	attack_sfx.pitch_scale = randf_range(0.5, 2)
	attack_sfx.play()
