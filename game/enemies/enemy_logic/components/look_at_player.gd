class_name EnemyLookAtPlayerLogic extends EnemyLogic

@export var object: Node2D

@export var instant: bool = true
@export var speed: float = 2.0

func process(delta: float) -> void:
	var player_pos := Game.get_player().global_position
	
	if instant:
		object.look_at(player_pos)
		return
	
	var vector_to_player := player_pos - enemy.global_position
	var angle_to_player := atan2(vector_to_player.y, vector_to_player.x)
	var new_angle := lerp_angle(object.rotation, angle_to_player, delta * speed)
	object.rotation = new_angle
