class_name PlayerClassSelection extends Control

@export var classes: Array[PlayerClass]

@onready var class_list: VBoxContainer = $ScrollContainer/ClassList

signal back_pressed

const CLASS_PICK = preload("res://menus/class_selection/class_pick.tscn")

func show_selection() -> void:
	visible = true
	
	for child in class_list.get_children():
		child.queue_free()
	
	var back_button: Button = Button.new()
	back_button.text = "Back"
	back_button.pressed.connect(back_pressed.emit)
	class_list.add_child(back_button)
	back_button.grab_focus()
	
	for player_class in classes:
		var class_pick: PlayerClassPick = CLASS_PICK.instantiate()
		class_list.add_child(class_pick)
		class_pick.set_class(player_class)

func hide_selection() -> void:
	visible = false
