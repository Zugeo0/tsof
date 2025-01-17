class_name Attack

var attacker: Node2D
var damage: int
var pierce: int

## Used to keep track of how much armor this current attack has pierced through
var pierce_count: int

func _init(attacker_: Node2D, damage_: int, pierce_: int) -> void:
	attacker = attacker_
	damage = damage_
	pierce = pierce_
