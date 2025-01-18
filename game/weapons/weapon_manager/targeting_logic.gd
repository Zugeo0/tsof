class_name TargetingLogic extends Node

@export var target_range: Area2D
@export var weapon_manager: WeaponManager
## A string which is evaluated into a sorting function.
@export_multiline var sort_function: String

var _targets: Array[Enemy]
var _expr: Expression = Expression.new()

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
	var idx: int = 0
	for weapon in get_children():
		weapon.set_target(_targets[idx])
		idx = (idx + 1) % _targets.size()
