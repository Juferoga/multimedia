extends Node2D

onready var bullet_manager = $BulletManager
onready var player: Player = $Player
#onready var base = $Base 
#onready var back_music_level1 = $BackMusicLevel1
onready var gui = $GUI
onready var spawn_timer = $SpawnTimer
onready var backsound_final = $BacksoundFinal

# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalSignals.connect("bullet_fired", bullet_manager, "handle_bullet_spawned")
	#Se agregan el jugador al canvas :D
	gui.set_player(player)
	backsound_final.play()
	
	
	
	
