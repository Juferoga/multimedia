extends Node2D

onready var bullet_manager = $BulletManager
onready var player: Player = $Player

var enemy = preload("res://Actors/Enemy.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalSignals.connect("bullet_fired", bullet_manager, "handle_bullet_spawned")
	$SpawnTimer.start()
	
	
	

func _on_SpawnTimer_timeout():
	var enemy_instance = enemy.instance()
	add_child(enemy_instance) 
	var spawn_locations = get_tree().get_nodes_in_group("spawn") 
	var chosen_location = spawn_locations[randi() % spawn_locations.size() ]
	enemy_instance.position = chosen_location.position # Establece la posición del enemigo recién generado en la ubicación elegida
	$SpawnTimer.start() # Reinicia el temporizador para la próxima generación
	

	
	
