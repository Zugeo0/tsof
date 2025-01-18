class_name GunProjectileSpawner extends Node2D

@onready var attack_timer: Timer = $AttackTimer
@onready var attack_cycle_timer: Timer = $AttackCycleTimer
@onready var gun_base: GunBase = $".."
@onready var bullet_spawn_position: Marker2D = $BulletSpawnPosition
@onready var attack_sfx: AudioStreamPlayer2D = $AttackSFX

var _can_attack: bool = false

func _ready() -> void:
	attack_cycle_timer.wait_time = gun_base.delay_between_attacks
	attack_timer.timeout.connect(func(): _can_attack = true)
	Game.get_player().frozen.connect(func(): attack_timer.paused = true)
	Game.get_player().unfrozen.connect(func(): attack_timer.paused = false)

func _process(_delta: float) -> void:
	if _can_attack:
		_attack()

func _reset_attack_timer() -> void:
	attack_timer.wait_time = gun_base.attack_speed / gun_base.attack_speed_mod
	attack_timer.start()

func _attack() -> void:
	var target = gun_base.get_target()
	if target != null:
		_can_attack = false
		for i in gun_base.attacks_per_cycle:
			_fire_gun()
			if i != gun_base.attacks_per_cycle:
				attack_cycle_timer.start()
				await attack_cycle_timer.timeout
		attack_timer.start()

func _fire_gun() -> void:
	var projectile_count: int = gun_base.total_projectiles()
	for j in projectile_count:
		var dir: Vector2 = _calculate_projectile_direction(
			projectile_count,
			gun_base.projectile_spread,
			j,
		)
		var proj: Projectile = gun_base.projectile_type.projectile_scene.instantiate()
		var data = ProjectileData.new(
			gun_base.added_damage,
			gun_base.damage_mod,
			gun_base.added_pierce,
			gun_base.projectile_velocity_mod,
			Game.get_player().player_stats.attack_damage_multiplier,
		)
		proj.init(dir, Game.get_player(), data)
		proj.top_level = true
		proj.global_position = bullet_spawn_position.global_position
		add_child(proj)
	_play_attack_sfx()

func _play_attack_sfx() -> void:
	# Randomly pitch the sound effect up/down to add variety.
	attack_sfx.pitch_scale = randf_range(0.5, 2)
	attack_sfx.play()

## Evaluates the direction for the provided projectile.
## total_projectiles -> The total number of projectiles fired in a single shot.
## angle -> The angle of the gun's spread.
## n -> When iterating, n is the value of the iterator (nth projectile fired).
func _calculate_projectile_direction(total_projectiles: int, angle: float, n: int) -> Vector2:
	## NOTE: If projectiles start acting funky when spawned, check if it's dividing by 0.
	var point_angle: float = 0.0
	if total_projectiles > 1:
		point_angle = -angle / 2.0 + n * (angle / max(total_projectiles - 1, 1))
	var dir := Vector2(cos(point_angle), sin(point_angle))
	return dir.rotated(gun_base.rotation)
