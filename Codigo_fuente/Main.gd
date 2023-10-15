extends Node2D

onready var bullet_manager = $BulletManager
onready var player: Player = $Player

var enemy_list = [
	{ "path": "res://Actors/Enemy.tscn", "weight": 5 }, 
	{ "path": "res://Actors/Enemy2.tscn", "weight": 1 },
	{ "path": "res://Actors/Enemy3.tscn", "weight": 15 }  
	
]

# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalSignals.connect("bullet_fired", bullet_manager, "handle_bullet_spawned")
	$SpawnTimer.start()

func _on_SpawnTimer_timeout():
	var total_weight = 0
	for enemy in enemy_list:
		total_weight += enemy["weight"]  

	var random_number = randf() * total_weight  

	var current_weight = 0
	var selected_enemy_path = ""
	for enemy in enemy_list:
		current_weight += enemy["weight"] 
		if random_number <= current_weight:  
			selected_enemy_path = enemy["path"]
			print("Spawnea un " + selected_enemy_path)
			break
			

	var enemy_instance = load(selected_enemy_path).instance()  
	add_child(enemy_instance)

	var spawn_locations = get_tree().get_nodes_in_group("spawn") 
	var chosen_location = spawn_locations[randi() % spawn_locations.size()]
	
	enemy_instance.position = chosen_location.position  
	$SpawnTimer.start()  

	
