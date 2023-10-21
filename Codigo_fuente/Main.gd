extends Node2D

onready var bullet_manager = $BulletManager
onready var player: Player = $Player
onready var base = $Base 


var active_enemies = []  # Lista para almacenar los enemigos activos
var weight_enemy = 0
var weight_enemy2 = 0
var weight_enemy3 = 0
var level = 1


var enemy_list = [
	{ "path": "res://Actors/Enemy.tscn", "weight": 0 }, #CALVO
	{ "path": "res://Actors/Enemy2.tscn", "weight": 0 }, #ROBOT
	{ "path": "res://Actors/Enemy3.tscn", "weight": 0 }  #ZOMBIE
]




# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalSignals.connect("bullet_fired", bullet_manager, "handle_bullet_spawned")
	player.connect("respawn_player", self, "clear_enemies")
	base.connect("change_difficulty", self, "increase_difficulty")
	level_configuration(level)
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
			#print("Spawnea un " + selected_enemy_path)
			break
			

	var enemy_instance = load(selected_enemy_path).instance()  
	add_child(enemy_instance)

	var spawn_locations = get_tree().get_nodes_in_group("spawn") 
	var chosen_location = spawn_locations[randi() % spawn_locations.size()]
	
	enemy_instance.position = chosen_location.position  
	$SpawnTimer.start()  
	
func clear_enemies():
	for enemy in get_tree().get_nodes_in_group("enemy"):
		enemy.queue_free()
		
func level_configuration(level: int):
	print("Level configuration")
	match level:
		1:
			enemy_list[0]["weight"] = 0
			enemy_list[1]["weight"] = 0
			enemy_list[2]["weight"] = 15
			$SpawnTimer.wait_time = 2.5
		2:
			enemy_list[0]["weight"] = 3
			enemy_list[1]["weight"] = 1
			enemy_list[2]["weight"] = 10
			$SpawnTimer.wait_time = 2
		3:
			enemy_list[0]["weight"] = 5
			enemy_list[1]["weight"] = 3
			enemy_list[2]["weight"] = 15
			$SpawnTimer.wait_time = 1
	
	
	
func increase_difficulty(baseTimer: int):
	var decrease_timer = 0.5
	print("Level difficulty")
	
	if $SpawnTimer.wait_time - decrease_timer != 0:
		$SpawnTimer.wait_time -= decrease_timer
		
	if baseTimer <= 60:
		print("calvo")
		enemy_list[0]["weight"] = 5
	if baseTimer <= 30:
		enemy_list[1]["weight"] = 3
	print($SpawnTimer.wait_time)
	
	pass

	
