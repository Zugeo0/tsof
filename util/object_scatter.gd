@tool
@icon("res://util/object_scatter.svg")
class_name ObjectScatter extends Node2D

@export var object: PackedScene

@export_range(1, 40, 1) var cell_count_x: int = 10
@export_range(1, 40, 1) var cell_count_y: int = 10
@export var spawn_range: Vector2i = Vector2i.ONE * 1000
@export var noise: FastNoiseLite
@export_range(0.0, 1.0, 0.05) var spawn_threshold: float = 0.5
@export var scatter_container: Node2D

@export var editor_show_grid: bool = false

var _object_pool: Array[Node2D]

func _ready() -> void:
	if Engine.is_editor_hint():
		return
	
	for i in range(cell_count_x * cell_count_y):
		var obj: Node2D = object.instantiate()
		obj.process_mode = Node.PROCESS_MODE_DISABLED
		obj.visible = false
		_object_pool.append(obj)
		
		var container: Node2D = scatter_container if scatter_container != null else self
		container.add_child.call_deferred(obj)

func _process(_delta: float) -> void:
	if Engine.is_editor_hint():
		queue_redraw()
		return
	
	# INFO: This is far from optimal. But for such a small project
	# this should be good enough. In the future this could be optimized
	# by either only updating when the grid is in a different position or
	# by adding a timer to only update every .5 seconds or something insead
	# of every frame
	var _rng: RandomNumberGenerator = RandomNumberGenerator.new()
	var cell_size: Vector2 = Vector2(spawn_range) / Vector2(cell_count_x, cell_count_y)
	for x in range(cell_count_x):
		for y in range(cell_count_y):
			var pos_offset: Vector2 = Vector2(fmod(global_position.x, cell_size.x), fmod(global_position.y, cell_size.y))
			var pos: Vector2 = -Vector2(spawn_range) / 2 + Vector2(x, y) * cell_size - pos_offset
			var global_pos: Vector2 = global_position + pos
			var sample: float = noise.get_noise_2d(global_pos.x, global_pos.y) + 0.5
			var index: int = x + y * cell_count_x
			
			if sample < spawn_threshold:
				hide_object(index)
				continue
			
			var sample_rand: float = fmod(sample, 0.01) / 0.01
			var point_offset_rad: float = sample_rand * 2 * PI
			var point_offset: Vector2 = Vector2.from_angle(point_offset_rad) * sample_rand * Vector2(cell_size) / 2.0 + Vector2(cell_size) / 2.0
			var point_pos: Vector2 = global_pos + point_offset
			show_object(index, point_pos)

func hide_object(index: int) -> void:
	var obj = _object_pool[index]
	obj.process_mode = Node.PROCESS_MODE_DISABLED
	obj.visible = false

func show_object(index: int, pos: Vector2) -> void:
	var obj = _object_pool[index]
	obj.process_mode = Node.PROCESS_MODE_INHERIT
	obj.visible = true
	obj.global_position = pos

func _draw() -> void:
	if not Engine.is_editor_hint():
		return
	
	draw_rect(Rect2(-Vector2i.ONE * spawn_range / 2, Vector2i.ONE * spawn_range), Color.BLUE, false)
	
	# INFO: There is a lot of code reuse here, but this has to be in the _draw()
	# function. This could be fixed by implementing this into a callback function
	# instead but since this is only an editor preview, implementing this as a callback
	# function is just gonna increase code obscurity without much benefit
	var _rng: RandomNumberGenerator = RandomNumberGenerator.new()
	var cell_size: Vector2 = Vector2(spawn_range) / Vector2(cell_count_x, cell_count_y)
	for x in range(cell_count_x):
		for y in range(cell_count_y):
			var pos_offset: Vector2 = Vector2(fmod(global_position.x, cell_size.x), fmod(global_position.y, cell_size.y))
			var pos: Vector2 = -Vector2(spawn_range) / 2 + Vector2(x, y) * cell_size - pos_offset
			var global_pos: Vector2 = global_position + pos
			var sample: float = noise.get_noise_2d(global_pos.x, global_pos.y) + 0.5
			
			if editor_show_grid:
				draw_rect(Rect2(pos, cell_size), Color.PURPLE * sample, true)
			
			if sample < spawn_threshold:
				continue
			
			var sample_rand: float = fmod(sample, 0.01) / 0.01
			var point_offset_rad: float = sample_rand * 2 * PI
			var point_offset: Vector2 = Vector2.from_angle(point_offset_rad) * sample_rand * Vector2(cell_size) / 2.0 + Vector2(cell_size) / 2.0
			draw_circle(pos + point_offset, 5.0, Color.RED, true)
