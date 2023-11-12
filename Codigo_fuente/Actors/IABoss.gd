extends Node2D

signal state_changed(new_state)

enum State {
	PATROL, 
	ENGAGE 
}

enum MovementPattern {
	CHASE_PLAYER,
	ZIGZAG,
	CIRCLE
}

var movement_pattern: int = MovementPattern.CHASE_PLAYER

onready var player_detection = $PlayerDetection

var current_state: int  = State.PATROL setget set_state
var player: Player = null 
var weapon: Weapon = null
var actor = null
var is_reloading = false

var movement_direction := Vector2.ZERO    
export (int) var speed = 100

var time_since_last_state_change: float = 0
var time_to_change_state: float = 5  # Tiempo en segundos

func _ready():
	pass
	
func _on_reload_started():
	is_reloading = true

func _on_reload_finished():
	is_reloading = false

func _process(delta: float) -> void:
	time_since_last_state_change += delta
	
	match current_state:
		State.PATROL:
			# Lógica de patrullaje
			pass
		State.ENGAGE:
			if player != null and weapon != null:
				actor.rotation = actor.global_position.direction_to(player.global_position).angle()
				
				# Cambio de estado aleatorio cada cierto tiempo
				if time_since_last_state_change > time_to_change_state:
					var new_state = rand_range(State.PATROL, State.ENGAGE)  # Obtiene un nuevo estado aleatorio
					set_state(new_state)
					time_since_last_state_change = 0  # Reinicia el contador de tiempo
				
				# Resto de la lógica ENGAGE aquí...
				match movement_pattern:
					MovementPattern.CHASE_PLAYER:
						movement_direction = global_position.direction_to(player.global_position)
						movement_direction = movement_direction.normalized() 
						actor.move_and_slide(movement_direction * speed)
					MovementPattern.ZIGZAG:
						movement_direction.y = sin(OS.get_ticks_msec() * 0.001)  # Movimiento en zigzag
						actor.move_and_slide(movement_direction * speed)
					MovementPattern.CIRCLE:
						var angle = OS.get_ticks_msec() * 0.001  # Incrementa el ángulo con el tiempo
						movement_direction.x = cos(angle)
						movement_direction.y = sin(angle)
						actor.move_and_slide(movement_direction * speed)
				
				weapon.shoot()
				if weapon.current_ammo == 0:
					weapon.start_reload()
			else:
				pass
		_:
			print("Error: state enemy unknown")

func initialize(actor, weapon: Weapon):
	self.actor = actor
	self.weapon = weapon    

func set_state(new_state: int):
	if new_state == current_state:
		return 
	
	current_state = new_state
	emit_signal("state_changed", current_state)

func handle_reload():
	weapon.start_reload()

func _on_PlayerDetection_body_entered(body):
	if body.is_in_group("player"):
		set_state(State.ENGAGE)
		player = body 

