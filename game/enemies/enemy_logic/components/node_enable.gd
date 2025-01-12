class_name EnemyNodeEnableLogic extends EnemyLogic

@export var object: Node2D

signal enable
signal disable

func enabled() -> void:
	enable.emit()

func disabled() -> void:
	disable.emit()
