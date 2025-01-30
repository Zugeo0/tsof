class_name EnemyKnockbackLogic extends EnemyLogic

@export var chase_logic: EnemyChaseLogic

## A multiplier to all knockback received by this entity. Higher values cause in higher knockback received.
@export_range(0.0, 2.0, 0.01) var knockback_mod: float = 1.0
@export var knockback_duration: float = 0.1

var knockback_duration_timer: Timer

func ready() -> void:
	enemy.damage_taken.connect(_apply_knockback)
	knockback_duration_timer = Timer.new()
	knockback_duration_timer.wait_time = knockback_duration
	add_child(knockback_duration_timer)

func _apply_knockback(atk: Attack) -> void:
	if not should_process:
		return
	
	chase_logic.chase = false
	chase_logic.add_force(atk.knockback * knockback_mod, true)
	if knockback_duration > 0.0:
		knockback_duration_timer.start()
		await knockback_duration_timer.timeout

	chase_logic.chase = true
