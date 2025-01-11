class_name RangedWeaponBase extends WeaponBase

var _weapon_type: RangedWeapon
var _weapon_manager: WeaponManager
var _current_target: Enemy

@onready var burst_timer: Timer = $BurstTimer
@onready var attack_timer: Timer = $AttackTimer
@onready var attack_sfx: AudioStreamPlayer = $AttackSFX
@onready var crosshair: Sprite2D = $Crosshair
@onready var sprite: Sprite2D = $Sprite
@onready var bullet_spawn_position: Marker2D = $BulletSpawnPosition

func _ready() -> void:
	Game.get_player().frozen.connect(func(): attack_timer.paused = true)
	Game.get_player().unfrozen.connect(func(): attack_timer.paused = false)

func _process(_delta: float) -> void:
	sprite.flip_v = global_transform.x.x < 0
	crosshair.visible = _current_target != null
	
	if _current_target != null:
		crosshair.global_position = _current_target.global_position
		look_at(_current_target.global_position)

func init(weapon_manager: WeaponManager, weapon_type: WeaponType) -> void:
	_weapon_type = weapon_type
	_weapon_manager = weapon_manager
	
	sprite.texture = _weapon_type.sprite
	attack_sfx.stream = _weapon_type.attack_sfx
	crosshair.texture = _weapon_type.crosshair
	attack_timer.wait_time = _weapon_type.delay_between_attacks

func set_target(target: Enemy) -> void:
	_current_target = target

func _on_attack_timer_timeout() -> void:
	var delay = _weapon_type.delay_between_attacks
	delay *= _weapon_manager.ranged_weapon_stats.attack_speed_mod
	delay *= Game.get_player().player_stats.attack_speed
	attack_timer.start(delay)
	_burst_attack()

func _fire_bullet() -> void:
	var projectile: Projectile = _weapon_type.projectile.instantiate()
	var direction = _calculate_spread_vector()
	var target = _current_target if is_instance_valid(_current_target) else null
	projectile.init(direction, Game.get_player(), target, [_weapon_type.stats, _weapon_manager.ranged_weapon_stats])
	projectile.top_level = true
	projectile.global_position = bullet_spawn_position.global_position
	add_child(projectile)
	_play_attack_sfx()

func _calculate_spread_vector() -> Vector2:
	var degrees = _weapon_type.projectile_spread.sample(randf()) / 2
	
	# Give the projectile a 50% chance of having the angle inverted
	var sign_multiplier = [-1, 1].pick_random()
	var rad = deg_to_rad(degrees)
	
	# Rotate the angle by rad or -rad
	var angle = global_transform.x.rotated(rad * sign_multiplier)
	return angle

func _burst_attack() -> void:
	if _weapon_type.delay_between_burst_projectiles > 0:
		burst_timer.wait_time = _weapon_type.delay_between_burst_projectiles
	
	for i in range(_weapon_type.projectile_count):
		_fire_bullet()
		
		if _weapon_type.delay_between_burst_projectiles > 0:
			burst_timer.start()
			await burst_timer.timeout

func _play_attack_sfx() -> void:
	# Randomly pitch the sound effect up/down to add variety.
	attack_sfx.pitch_scale = randf_range(0.5, 2)
	attack_sfx.play()
