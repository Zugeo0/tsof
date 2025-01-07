class_name ExperienceBar extends ProgressBar

@onready var experience_label: Label = $Experience

func update_bar(experience: int, level_requirement: int) -> void:
	max_value = level_requirement
	value = experience
	experience_label.text = "%d/%d" % [experience, level_requirement]
