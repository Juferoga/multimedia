extends KinematicBody2D

onready var health_stat = $Health
onready var ia = $IA
onready var weapon: Weapon = $Weapon
onready var team = $Team
onready var attack_animation = $AnimationPlayer
onready var death_sound = $DeathSound2
onready var spawn_timer = $SpawnTimer

var is_diyng = false 



func _ready() -> void: 
	ia.initialize(self, weapon)
	weapon.initialize(team.team)
	spawn_timer.start()

func handle_hit():
	health_stat.health -= 100
	if health_stat.health <= 0:
		is_diyng = true
		attack_animation.play("DeathAnimation")
		death_sound.play()
	
func get_team() -> int:
	return team.team

func _on_animation_finished():
	queue_free()
	
	
	
func _on_SpawnTimer_timeout():
	print("Timeout")
	var selected_enemy_path = "res://Actors/Slime.tscn"
	
	var enemy_instance = load(selected_enemy_path).instance()  
	add_child(enemy_instance)

	var spawn_locations = get_tree().get_nodes_in_group("spawn") 
	var chosen_location = spawn_locations[randi() % spawn_locations.size()]
	
	enemy_instance.position = chosen_location.position  
	spawn_timer.start()  
