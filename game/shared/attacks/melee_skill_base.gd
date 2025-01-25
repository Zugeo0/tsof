@tool
class_name MeleeSkillBase extends SkillBase

@export_range(0.0, 2*PI)
var angle: float = PI/2.0

@export_range(0.0, 1.0)
var cutoff_distance: float = 0.0

@export_range(2, 20)
var collision_accuracy: int = 10

@export_range(0.1, 10.0, 0.01, "or_greater", "suffix:s", "hide_slider")
var windup_time: float = 1.0

@export var include_cutoff_in_collision: bool = false

@export var base_damage: int = 10
@export var added_damage_effectiveness: float = 1.0

@export var size: float = 100.0

@export var wave_color_1: Color = Color.WHITE
@export var wave_color_2: Color = Color.BLACK
## The timer used for cooldown or windup. This determines the state of the
## AoE cone polygon. The desired timer can be dragged into the property in the
## editor if you enable "editable children" under the skill's PackedScene in the
## scene tree.
@export var primary_timer: Timer

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collision_polygon_2d: CollisionPolygon2D = $CollisionPolygon2D
## NOTE: Only use either the cooldown timer or the windup timer. Using both
## may lead to some weird things happening.
@onready var cooldown_timer: Timer = $CooldownTimer
@onready var windup_timer: Timer = $WindupTimer

func _ready() -> void:
	_setup()

func _process(_delta: float) -> void:
	if Engine.is_editor_hint():
		sprite_2d = $Sprite2D
		collision_polygon_2d = $CollisionPolygon2D
		_setup()
		return
	
	_set_opacity(1.0 - primary_timer.time_left / primary_timer.wait_time)

func _setup() -> void:
	_setup_gradient()
	_setup_material()
	_setup_collision()

func _setup_gradient() -> void:
	# TODO: Update this so that the editor isn't constantly creating
	# a new gradient every single frame
	var tex := GradientTexture2D.new()
	tex.gradient = Gradient.new()
	tex.gradient.colors[0] = wave_color_1
	tex.gradient.colors[1] = wave_color_2
	tex.width = 100
	tex.height = 100
	sprite_2d.scale = Vector2.ONE * (size / 50.0)
	sprite_2d.texture = tex

func _setup_material() -> void:
	var mat: ShaderMaterial = sprite_2d.material
	mat.set_shader_parameter("cone_angle", angle)
	mat.set_shader_parameter("cutoff_distance", cutoff_distance)

func _setup_collision() -> void:
	var points := PackedVector2Array()
	points.append(Vector2.ZERO)
	
	for i in range(collision_accuracy):
		var point_angle := -angle / 2.0 + i * (angle / (collision_accuracy - 1))
		var point := Vector2(cos(point_angle), sin(point_angle)) * size
		points.append(point)
	
	if include_cutoff_in_collision and cutoff_distance > 0.0 and cutoff_distance < 1.0:
		for i in range(collision_accuracy):
			var point_angle := angle / 2.0 - i * (angle / (collision_accuracy - 1))
			var point := Vector2(cos(point_angle), sin(point_angle)) * size * cutoff_distance
			points.append(point)
	
	collision_polygon_2d.polygon = points


func activate(atk: Attack) -> void:
	for object in get_overlapping_bodies():
		if object.has_method("take_damage"):
			object.take_damage(atk)
	
	_flash_sprite()

## Starts the cooldown timer for this skill.
## cd -> The wait time for the timer.
func start_cooldown(cd: float) -> void:
	cooldown_timer.start(cd)
	visible = true
	_set_opacity(0.0)

func _flash_sprite() -> void:
	var mat: ShaderMaterial = sprite_2d.material
	mat.set_shader_parameter("flash", true)
	await get_tree().create_timer(0.1).timeout
	mat.set_shader_parameter("flash", false)

func _set_opacity(opacity: float) -> void:
	var mat: ShaderMaterial = sprite_2d.material
	mat.set_shader_parameter("opacity", opacity)

## Starts the skill's windup.
func start_windup() -> void:
	windup_timer.start(windup_time)
	visible = true
	_set_opacity(0.0)

## Stops the skill's windup instantly.
func stop_windup() -> void:
	windup_timer.stop()
	visible = false

func has_targets() -> bool:
	return len(get_overlapping_bodies()) > 0
