class_name EnemyMoveFlipSpriteLogic extends EnemyLogic

@export var invert: bool = false
@export var sprite: Sprite2D

func process(_delta: float) -> void:
	if enemy.linear_velocity.x < 0:
		sprite.flip_h = not invert
	elif enemy.linear_velocity.x > 0:
		sprite.flip_h = invert
