extends Node2D

onready var bullet_manager = $BulletManager
onready var player: Player = $Player
#onready var base = $Base 
#onready var back_music_level1 = $BackMusicLevel1
onready var gui = $GUI
onready var spawn_timer = $SpawnTimer
onready var backsound_final = $BacksoundFinal
onready var sound_dead = $SoundRock
onready var timer_menu = $TiempoAMenu
onready var final_sound = $FinalMusic

# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalSignals.connect("bullet_fired", bullet_manager, "handle_bullet_spawned")
	#Se agregan el jugador al canvas :D
	gui.set_player(player)
	backsound_final.play()
	
	var boss_node = $FinalBoss
	# Conectar la señal del nodo hijo a una función en el nodo padre
	boss_node.connect("boss_dead", self, "_on_boss_dead")
	
	var player = get_node("Player")
	player.connect("is_player_dead", self, "_on_custom_signal_received")
	
func _on_boss_dead():
	backsound_final.stop()
	sound_dead.play()
	timer_menu.start()
	final_sound.play()
	
func _on_TiempoAMenu_timeout():
	#Poner la escena del menu
	#get_tree().change_scene("res://Main.tscn")
	pass

func _on_custom_signal_received():
	backsound_final.stop()
	$MusicDead.play()
