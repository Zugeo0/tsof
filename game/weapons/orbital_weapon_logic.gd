@tool
class_name OrbitalWeaponLogic extends WeaponBase

## The weapon type that rotates around the player.
@export var weapon: PackedScene
## The rate at which the weapons rotate around the player.
@export var rotation_speed: float
## The distance between the weapons and the player.
@export var radius: float
## The number of weapons orbiting this node.
@export_range(1, 10, 1, "or_greater") var weapon_count: int = 1:
	set(value):
		## TODO: Move to a dedicated setter function or something
		var delta = value - weapon_count
		weapon_count = value
		_reevaluate_children(delta)

var _player_stats: PlayerStats

func _ready() -> void:
	if Engine.is_editor_hint():
		_player_stats = PlayerStats.new()
	else:
		_player_stats = Game.get_player().player_stats
	for i in range(weapon_count):
		add_weapon()
	_setup_children()

func _process(delta: float) -> void:
	if Engine.is_editor_hint():
		_setup_children()
	rotate(((rotation_speed / PI) * delta) * _player_stats.attack_speed_mod)

func _setup_children() -> void:
	_reposition_children()
	_resize_children()

func add_weapon() -> void:
	var wpn: OrbitalWeaponBase = weapon.instantiate()
	add_child(wpn)
	wpn.set_logic(self)

func _reevaluate_children(wpn_delta: int) -> void:
	if wpn_delta == 0:
		return
	elif wpn_delta < 0:
		var children = get_children()
		for i in range(abs(wpn_delta)):
			var c = children.pop_back()
			c.queue_free()
	else:
		for i in range(wpn_delta):
			add_weapon()
	_reposition_children()

func _get_radius() -> float:
	return radius * _player_stats.area_of_effect_mod

func _resize_children() -> void:
	var children: Array[OrbitalWeaponBase] = []
	children.assign(get_children())
	for child in children:
		child.scale = Vector2.ONE * _player_stats.area_of_effect_mod

func _reposition_children() -> void:
	var children = get_children()
	var rad = _get_radius()
	for i in range(children.size()):
		var child = children[i]
		var theta = (2 * PI) * (float(i) / children.size())
		var pos = Vector2(cos(theta), sin(theta)) * rad
		child.position = pos
		var dir = Vector2(-sin(theta), cos(theta))
		child.rotation = atan2(dir.y, dir.x)
