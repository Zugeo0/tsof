class_name Player extends CharacterBody2D

const SPEED: float = 8.0

signal damage_taken(dealt: int)
signal levelup

@onready var sprite: Sprite2D = $Visuals/Sprite
@onready var invincibility_timer: Timer = $InvincibilityTimer
@onready var experience_pickup_sfx: AudioStreamPlayer = $ExperiencePickupSFX
@onready var collection_range: Area2D = $CollectionRange
@onready var hurt_sfx: AudioStreamPlayer = $HurtSFX
@onready var camera: Camera2D = $Camera
@onready var weapon_manager: WeaponManager = $WeaponManager

@export var stats: PlayerStats

var current_experience: int = 0
var current_level: int = 0

var _freeze: bool = false

signal frozen
signal unfrozen

func _ready() -> void:
	var current_class = RunSettings.get_current_player_class()
	if current_class != null:
		stats = current_class.duplicate()
	
	for weapon in stats.starting_weapons:
		weapon_manager.add_weapon(weapon)

func _physics_process(_delta: float) -> void:
	if _freeze:
		return
	
	var x_move = Input.get_axis("move_left", "move_right")
	var y_move = Input.get_axis("move_up", "move_down")
	var move = Vector2(x_move, y_move).normalized()
	
	if x_move != 0.0:
		# Using scale instead of flip_h since the sprite is not centered
		sprite.scale.x = -1 if x_move < 0 else 1
	
	velocity = move * SPEED * 50.0
	move_and_slide()
	
	for obj in collection_range.get_overlapping_areas():
		if obj is Pickup:
			obj.track_object(self)

func take_damage(_source: Enemy, amt: int, pierce: int) -> int:
	if invincibility_timer.time_left > 0:
		return pierce - stats.armor - 1
	
	invincibility_timer.wait_time = stats.invincibility_time
	invincibility_timer.start()
	
	stats.health = max(stats.health - amt, 0)
	damage_taken.emit(amt)
	
	_flash_sprite.call_deferred()
	hurt_sfx.play()
	
	return pierce - stats.armor - 1

func _flash_sprite() -> void:
	var sprite_material: ShaderMaterial = sprite.material
	sprite_material.set_shader_parameter("flash", true)
	await get_tree().create_timer(0.1).timeout
	sprite_material.set_shader_parameter("flash", false)

func add_xp(amt: int) -> void:
	current_experience += amt
	
	var required_for_levelup = get_xp_requirement(current_level)
	
	experience_pickup_sfx.pitch_scale = clamp(1.0 + (float(current_experience) / float(required_for_levelup)), 0.1, 2)
	experience_pickup_sfx.play()
	
	while current_experience >= required_for_levelup:
		current_level += 1
		current_experience -= required_for_levelup
		
		required_for_levelup = get_xp_requirement(current_level)
		levelup.emit()

## Calculates how much xp is needed to reach the level after the one provided
func get_xp_requirement(level: int) -> int:
	return (level ** 2) + (3 * level) + 10

func set_zoom(zoom: float) -> void:
	camera.zoom = Vector2.ONE * zoom

func get_weapon_manager() -> WeaponManager:
	return weapon_manager

func teleport(pos: Vector2) -> void:
	global_position = pos
	camera.reset_smoothing()

func set_freeze(freeze: bool) -> void:
	_freeze = freeze
	
	if freeze:
		frozen.emit()
	else:
		unfrozen.emit()