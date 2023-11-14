extends KinematicBody2D

onready var health_stat = $Health
onready var ia = $IABoss
onready var weapon: Weapon = $Weapon
onready var team = $Team
onready var attack_animation = $AnimationPlayer
onready var death_sound = $DeathSound2
onready var spawn_timer = $SpawnTimer
onready var hit_boss = $hitBoss
onready var sound_fase2 = $Fase2Sound
onready var sound_fase3 = $Fase3Sound
onready var sound_fase4 = $Fase4Sound



var is_diyng = false 

signal set_fase



func _ready() -> void: 
	ia.initialize(self, weapon)
	weapon.initialize(team.team)
	spawn_timer.start()

func handle_hit():
	hit_boss.play()
	health_stat.health -= 2
	#Diferentes fases por vida
	if health_stat.health == 76: 
		sound_fase2.play()
		attack_animation.play("Fase1")
		emit_signal("set_fase", health_stat.health)
	if health_stat.health == 50: 
		attack_animation.play("Fase 2")
		sound_fase3.play()
		emit_signal("set_fase", health_stat.health)
	if health_stat.health == 26: 
		sound_fase4.play()
		attack_animation.play("Fase 3")		
		emit_signal("set_fase", health_stat.health)
		pass
	if health_stat.health <= 0:
		is_diyng = true
		attack_animation.play("DeathAnimation")
		death_sound.play()
	
func get_team() -> int:
	return team.team

func _on_animation_finished():
	queue_free()


	
func _on_animation_fase_start():
	get_node("CollisionShape2D").disabled = true
	

func _on_animation_fase_finished():
	get_node("CollisionShape2D").disabled = false
	
	
	
func _on_SpawnTimer_timeout():
	#print("Timeout")
	var selected_enemy_path = "res://Actors/Slime.tscn"
	
	var enemy_instance = load(selected_enemy_path).instance()
	
	var spawn_locations = get_tree().get_nodes_in_group("spawn") 
	var chosen_location = spawn_locations[randi() % spawn_locations.size()]
	
	# Obtén el nodo padre del enemigo principal
	var enemy_parent = get_parent()

	# Configura la posición en el mundo en lugar de la posición local
	enemy_instance.global_position = chosen_location.global_position  

	# Agrega el enemigo al mismo nivel en el árbol de nodos que el enemigo principal
	enemy_parent.add_child(enemy_instance)
	
	spawn_timer.start()  
