class_name Enemy extends RigidBody2D

@export_group("Info")

@export var enemy_name: String = ""
@export var drops: Array[EnemyDrop] = []
@export var sprite: Sprite2D
@export var damage_sfx: AudioStreamPlayer
@export var death_effect: PackedScene
@export var threat_level: int

@export_group("Stats")

## The entity's armor (damage reduction)
@export var armor: int

## The amount of damage this entity can take before dying.
@export var max_health: int

## The entity's current health
@export var health: int

signal death
signal damage_taken(atk: Attack)

var _dead: bool = false

const MAX_DIST_FROM_PLAYER: float = 3000.0

func take_damage(attack: Attack) -> void:
	if _dead:
		return
	
	damage_taken.emit(attack)
	health -= attack.damage
	
	if health <= 0:
		kill()
	
	_flash_sprite.call_deferred()
	
	damage_sfx.pitch_scale = randf_range(0.8, 1.2)
	damage_sfx.play()
	
	attack.pierce_count += armor + 1

func _physics_process(_delta: float) -> void:
	var player_pos = Game.get_player().global_position
	var dist_from_player = global_position.distance_to(player_pos)

	if dist_from_player > MAX_DIST_FROM_PLAYER:
		var offset_from_player = Vector2.from_angle(randf() * 2 * PI) * MAX_DIST_FROM_PLAYER * randf_range(0.8, 1.0)
		global_position = player_pos + offset_from_player
		

func kill(drop_pickups: bool = true) -> void:
	if drop_pickups:
		_spawn_drops()
	
	var death_effect_node = death_effect.instantiate()
	var level: Level = Game.get_level_manager().get_current_level()
	level.add_object(death_effect_node, global_position)
	
	death.emit()
	queue_free()
	_dead = true

func _spawn_drops() -> void:
	for drop in drops:
		if randf() * 100 > drop.chance:
			continue
		
		var pickup: Pickup = drop.scene.instantiate()
		pickup.value = drop.value
		
		var level: Level = Game.get_level_manager().get_current_level()
		level.add_object.call_deferred(pickup, global_position)

func _flash_sprite() -> void:
	var mat: ShaderMaterial = sprite.material
	mat.set_shader_parameter("flash", true)
	await get_tree().create_timer(0.1).timeout
	mat.set_shader_parameter("flash", false)
