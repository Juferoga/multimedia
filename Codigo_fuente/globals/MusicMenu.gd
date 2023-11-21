extends Node

var music = preload("res://Sounds/Music/final_bosscutscene.wav")
var music_stream = AudioStreamPlayer.new()
var is_playing = false

func _ready():
	music_stream.volume_db = -5
	add_child(music_stream)

	if not music_stream.is_connected("finished", self, "_on_music_finished"):
		music_stream.connect("finished", self, "_on_music_finished")

func play_music():
	music_stream.stop()
	music_stream.set_stream(music)
	music_stream.play()
	is_playing = true

func stop_music():
	music_stream.stop()
	is_playing = false

func _on_music_finished():
	if is_playing:
		play_music()

