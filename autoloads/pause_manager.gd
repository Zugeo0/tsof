extends Node

var _pause_tracker: Array[Node] = []

func set_pause(id: Node, paused: bool) -> void:
	if paused:
		pause(id)
	else:
		unpause(id)

func toggle_pause(id: Node) -> void:
	if id in _pause_tracker:
		unpause(id)
	else:
		pause(id)

func pause(id: Node) -> void:
	if id in _pause_tracker:
		return
	
	_pause_tracker.append(id)
	get_tree().paused = true

func unpause(id: Node) -> void:
	var idx = _pause_tracker.find(id)
	if idx == -1:
		return
	
	_pause_tracker.remove_at(idx)
	if _pause_tracker.size() == 0:
		get_tree().paused = false

func reset_pause() -> void:
	_pause_tracker.clear()
	get_tree().paused = false

func is_paused() -> bool:
	return _pause_tracker.size() > 0
