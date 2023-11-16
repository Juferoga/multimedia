extends Node

var music = preload("res://Sounds/Music/final_bosscutscene.wav")

var is_playing = false
var music_stream

func play_music():
	music_stream = AudioStreamPlayer.new()
	music_stream.stream = music
	music_stream.volume_db = -20
	music_stream.play()
	add_child(music_stream)
	is_playing = true
	
func stop_music():
	if is_playing and music_stream:
		var duration = 1.0  # Duración de la transición en segundos
		var start_volume = music_stream.volume_db
		var end_volume = -80  # Volumen al que se detendrá la música, por ejemplo -80 para silenciarla
		var current_time = 0.0

		while current_time < duration:
			var new_volume = lerp(start_volume, end_volume, current_time / duration)
			music_stream.volume_db = new_volume
			yield(get_tree().create_timer(get_process_delta_time()), "timeout")
			current_time += get_process_delta_time()

		music_stream.stop()
		is_playing = false


