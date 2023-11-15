extends KinematicBody2D

class_name Player



export (int) var speed = 250

var is_reloading = false
var initial_position: Vector2
var is_alive = true


var lives: int 

var text

var player_dead = false


onready var weapon: Weapon = $Weapon
onready var health_stat = $Health
onready var team = $Team
onready var pain_sounds = $PainSounds
onready var game_over = $GameOver
onready var lost_life = $LostLife
#onready var player_data_node = $PlayerData

#onready var player_data = get_node("res://Actors/PlayerData.gd")

signal respawn_player
signal player_health_changed(new_health)
signal player_current_ammo_changed(new_current_ammo)
signal player_max_ammo_changed(new_max_ammo)
signal player_current_lifes_changed(new_current_lifes)
signal player_max_lifes_changed(new_max_lifes)
signal is_player_dead 

#Depuracion 


func _ready():
	initial_position = global_position
	weapon.initialize(team.team)
	weapon.connect("reload_started", self, "_on_reload_started")
	weapon.connect("reload_finished", self, "_on_reload_finished")
	## Inicializa las variables de munición actual y total
	lives = PLAYERDATA.current_lives
	health_stat.health = PLAYERDATA.player_health
	
	#emit_initial_signals()
	
	
	
	

func emit_initial_signals():
	print("Inicializacion de las variables")
	print("Vidas", lives)
	emit_signal("player_health_changed", health_stat.health)
	emit_signal("player_current_ammo_changed", weapon.current_ammo)
	emit_signal("player_max_ammo_changed", weapon.max_ammo)
	emit_signal("player_current_lifes_changed", lives)
	emit_signal("player_max_lifes_changed", lives)
	#emit_signal("player_depuracion", text)


func _on_reload_started():
	is_reloading = true

func _on_reload_finished():
	is_reloading = false

#Función que es llamada cada frame
func _physics_process(delta: float) -> void:
	var movement_direction := Vector2.ZERO	
	if is_alive:
		if Input.is_action_pressed("up"):
			movement_direction.y = -1
		if Input.is_action_pressed("down"):
			movement_direction.y = 1
		if Input.is_action_pressed("right"):
			movement_direction.x = 1
		if Input.is_action_pressed("left"):
			movement_direction.x = -1 
	
	movement_direction = movement_direction.normalized() 
	move_and_slide(movement_direction * speed)
	
	look_at(get_global_mouse_position())
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("shoot") and not is_reloading and is_alive:
		weapon.shoot()
		
	elif event.is_action_released("reload") and not is_reloading and is_alive:
		weapon.start_reload()
	
	if event.is_action_pressed("toggle_debug"):
		pass
		
		
	
	emit_signal("player_current_ammo_changed", weapon.current_ammo)

	
func handle_hit():
	health_stat.health -= 20
	PLAYERDATA.set_health(health_stat.health)
	emit_signal("player_health_changed", health_stat.health)
	if health_stat.health <= 0:
		lose_life()
	else:
		var sound_index = randi() % 5  # Genera un índice aleatorio entre 0 y 4
		var sound_to_play = pain_sounds.get_child(sound_index)
		if sound_to_play is AudioStreamPlayer2D:
			sound_to_play.play()
		
		
func reload(): 
	weapon.start_reload()
			
func get_team() -> int:
	return team.team
	
func lose_life():
	lives -= 1
	PLAYERDATA.set_lives(lives)
	
	emit_signal( "player_current_lifes_changed", lives)
	if lives <= 0:
		game_over.play()
		player_death()
		print("Game Over")
		var player_dead = true
		emit_signal("is_player_dead")
	else:
		# Aquí se realizarían las acciones para cuando el jugador pierde una vida pero aún tiene vidas restantes, como reiniciar la posición del jugador o reiniciar la escena
		lost_life.play()
		health_stat.health = 100
		emit_signal("player_health_changed", health_stat.health)
		global_position = initial_position
		emit_signal("respawn_player")
		PLAYERDATA.set_health(health_stat.health)
		print("Lost a life, remaining lives:", lives)
		#Emitir una señal  
		# Restaurar la salud del jugador u otras acciones necesarias para reiniciar el estado del jugador
	
func player_death():
	is_alive = false
	self.visible = false  # Desactiva el renderizado del enemigo
	self.collision_layer = 0  # Deshabilita la colisión del enemigo
	self.collision_mask = 0
	
	
	
	
	
		
	
