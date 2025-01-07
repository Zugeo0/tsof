extends AudioStreamPlayer

signal fade_out_complete
signal fade_in_complete

var tween: Tween

func _ready() -> void:
	bus = "Music"
	volume_db = linear_to_db(0.01)
	process_mode = PROCESS_MODE_ALWAYS


func start_immediate(audio_stream: AudioStream) -> void:
	_stop_tween()
	stream = audio_stream
	volume_db = linear_to_db(1.0)
	play()

func stop_immediate() -> void:
	_stop_tween()
	stop()

func fade_out(duration: float = 5.0) -> void:
	_stop_tween()
	tween = create_tween()
	tween.tween_property(self, "volume_db", linear_to_db(0.01), duration)
	tween.tween_callback(_fade_out_tween_callback)


func fade_in(audio_stream: AudioStream, duration: float = 5.0) -> void:
	_stop_tween()
	
	stream = audio_stream
	play()
	
	tween = create_tween()
	tween.tween_property(self, "volume_db", linear_to_db(1.0), duration)
	tween.tween_callback(_fade_in_tween_callback)


func cross_fade(audio_stream: AudioStream, out_duration: float = 2.0, in_duration: float = 2.0) -> void:
	fade_out(out_duration)
	tween.tween_callback(fade_in.bind(audio_stream, in_duration))


func _fade_out_tween_callback() -> void:
	stop()
	fade_out_complete.emit()


func _fade_in_tween_callback() -> void:
	fade_in_complete.emit()


func _stop_tween() -> void:
	if tween != null:
		tween.kill()
