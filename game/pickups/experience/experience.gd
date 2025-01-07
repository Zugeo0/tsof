class_name Experience extends Pickup

## The amount of xp needed per sprite frame
@export var sprite_break_points: int = 10

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _process(_delta: float) -> void:
	animated_sprite.frame = value / sprite_break_points

func pickup() -> void:
	Game.get_player().add_xp(value)
