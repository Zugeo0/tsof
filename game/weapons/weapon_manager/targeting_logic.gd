class_name TargetingLogic extends Node

@export var target_range: Area2D
@export var weapon_manager: WeaponManager
## If an enemy with a threat level equal to- or higher than this value,
## all weapons in this group will prioritize them instead of their usual
## targeting priorities.
@export var threat_priority_threshold: int
## A string which is evaluated into a sorting function.
## The available variables (as of writing the docstring) are:
## a (an instance of Enemy), b (another instance of Enemy)
## and player (self-explanatory).
@export_multiline var sort_function: String

var _targets: Array[Enemy]
var _priority_targets: Array[Enemy]
var _expr: Expression = Expression.new()

func _ready() -> void:
	target_range.body_entered.connect(_assign_priority)
	target_range.body_exited.connect(_remove_priority)

func _process(_delta: float) -> void:
	_reevaluate_targets()
	if len(_targets) > 0:
		_assign_targets()

func _reevaluate_targets() -> void:
	_targets.assign(target_range.get_overlapping_bodies())
	var err = _expr.parse(sort_function, ["a", "b", "player"])
	if err != OK:
		push_error("Invalid expression in TargetingLogic node: %s" % _expr.get_error_text())
		return
	_targets.sort_custom(func(a, b): return _expr.execute([a, b, Game.get_player()], self))

func _assign_targets() -> void:
	if len(_priority_targets) > 0:
		for weapon in get_children():
			weapon.set_target(_priority_targets[0])
	else:
		var idx: int = 0
		for weapon in get_children():
			weapon.set_target(_targets[idx])
			idx = (idx + 1) % _targets.size()

func _assign_priority(body: Enemy) -> void:
	if body.threat_level > threat_priority_threshold:
		_priority_targets.push_back(body)
		_priority_targets.filter(
			func(a): return a.threat_level >= threat_priority_threshold
		)

func _remove_priority(body: Enemy) -> void:
	if body.threat_level > threat_priority_threshold:
		var index: int = _priority_targets.find(body)
		if index != -1:
			_priority_targets.remove_at(index)
