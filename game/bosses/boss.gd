class_name Boss extends Enemy

@onready var enemy_manager: EnemyManager = %EnemyManager

func _ready() -> void:
	enemy_manager.register_boss(self)
