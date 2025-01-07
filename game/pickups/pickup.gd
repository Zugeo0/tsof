@icon("res://game/pickups/pickup.svg")
class_name Pickup extends Area2D

@export var value: int = 1
@export var clump_id: String
@export var clump_area: Area2D

const TRACKING_SPEED = 8.0

var _track_node: Node2D
var _despawn_timer: Timer

const DESPAWN_TIME: float = 30.0

func _ready() -> void:
	body_entered.connect(_on_pickup)
	area_entered.connect(_on_clump)
	
	_despawn_timer = Timer.new()
	_despawn_timer.timeout.connect(queue_free)
	add_child(_despawn_timer)
	
	_despawn_timer.start(DESPAWN_TIME)

func _physics_process(delta: float) -> void:
	if is_tracking():
		global_position = global_position.move_toward(_track_node.global_position, delta * TRACKING_SPEED * 100.0)
	
	for node in clump_area.get_overlapping_areas():
		var pickup_node: Pickup = node
		
		if pickup_node == self:
			continue
		
		if not pickup_node.is_tracking():
			track_object(pickup_node)

func _on_pickup(_body: Node2D) -> void:
	pickup()
	queue_free()

func _on_clump(area: Area2D) -> void:
	var pickup_node: Pickup = area
	
	if not is_tracking() or pickup_node.clump_id != clump_id:
		return
	
	pickup_node.value += value
	pickup_node._despawn_timer.start(DESPAWN_TIME)
	queue_free()

func pickup() -> void:
	pass

func track_object(node: Node2D) -> void:
	_track_node = node

func is_tracking() -> bool:
	return _track_node != null
