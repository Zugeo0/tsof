class_name EnemyContactDamageLogic extends EnemyLogic

## The damage dealt to opposing entities on contact
@export var contact_damage: int
@export var cooldown: float = 0.5
@export var kill_self_on_contact: bool = false

@export var hitbox: Area2D

var _cooldown_timer: Timer

func ready() -> void:
	_cooldown_timer = Timer.new()
	_cooldown_timer.one_shot = true
	_cooldown_timer.process_mode = Node.PROCESS_MODE_PAUSABLE
	add_child(_cooldown_timer)

func evaluate() -> bool:
	# Pause the timer if the logic is paused
	_cooldown_timer.paused = Game.get_enemy_manager().paused
	
	return _cooldown_timer.time_left == 0.0

func physics_process(_delta: float) -> void:
	var start_cooldown = false
	
	for body in hitbox.get_overlapping_bodies():
		if body.has_method("take_damage"):
			start_cooldown = true
			
			var attack := Attack.new(enemy, contact_damage, 0)
			body.take_damage(attack)
			
			if kill_self_on_contact:
				enemy.kill(false)
	
	if start_cooldown:
		_cooldown_timer.wait_time = cooldown
		_cooldown_timer.start()
