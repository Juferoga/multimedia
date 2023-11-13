extends Node2D

signal state_changed(new_state)

enum State {
	PATROL, 
	ENGAGE 
}

enum MoveState {
	ENGAGE_DIRECT, 
	ENGAGE_DASH,
	ENGAGE_RANDOM_DIRECTION,
	ENGAGE_SIDE_TO_SIDE
}

onready var player_detection = $PlayerDetection

var current_state: int  = State.PATROL setget set_state
var current_move_state: int = MoveState.ENGAGE_DIRECT setget set_move_state
var player: Player = null 
var weapon: Weapon = null
var actor = null
var is_reloading = false

var dash_speed = 500

var movement_direction := Vector2.ZERO    
export (int) var speed = 100

# Temporizador para cambiar aleatoriamente los estados de movimiento
var move_state_timer := Timer.new()

func _ready():
	add_child(move_state_timer)
	move_state_timer.one_shot = false
	move_state_timer.wait_time = 5.0
	move_state_timer.connect("timeout", self, "_on_move_state_timer_timeout")
	move_state_timer.start()

func _on_reload_started():
	is_reloading = true

func _on_reload_finished():
	is_reloading = false

func _on_move_state_timer_timeout():
	set_move_state_random()
	move_state_timer.start()

func _process(delta: float) -> void:
	match current_state:
		State.PATROL:
			pass
		State.ENGAGE:
			if player != null and weapon != null:
				# Llama a la función de movimiento actual
				move_pattern()
				weapon.shoot() 
				if weapon.current_ammo == 0 :
					weapon.start_reload()
			else:
				pass
		_:
			print("Error: estado de enemigo desconocido")

func move_pattern(): 
	match current_move_state:
		MoveState.ENGAGE_DIRECT:
			engage_direct_movement()
		MoveState.ENGAGE_DASH:
			engage_dash_movement()
		MoveState.ENGAGE_RANDOM_DIRECTION:
			engage_random_direction_movement()
		MoveState.ENGAGE_SIDE_TO_SIDE:
			engage_side_to_side_movement()
		_:
			print("Error: subestado de enemigo desconocido")
			
func set_move_state_random():
	# Obtener el tamaño del enum MoveState
	var move_states = MoveState.values()
	
	# Seleccionar aleatoriamente un estado de movimiento
	var random_state = move_states[randi() % move_states.size()]
	current_move_state = random_state
	print("Random Move State: ", current_move_state)

	
				
func engage_direct_movement():
	if player != null:
		actor.rotation = actor.global_position.direction_to(player.global_position).angle()
		movement_direction = global_position.direction_to(player.global_position)
		movement_direction = movement_direction.normalized() 
		actor.move_and_slide(movement_direction * speed)
	

var dash_duration = 0.5
var time_since_dash_start = 0.0
var dash_state = 0

func engage_dash_movement():
	if player != null:
		actor.rotation = actor.global_position.direction_to(player.global_position).angle()
		movement_direction = global_position.direction_to(player.global_position).normalized()
		actor.move_and_slide(movement_direction * dash_speed)
		time_since_dash_start += get_process_delta_time()

		if time_since_dash_start >= dash_duration:
			time_since_dash_start = 0.0
			set_move_state_random()  # Cambiar a otro estado después de 1 segundo

		
		
	
	
func engage_random_direction_movement():
	actor.rotation = actor.global_position.direction_to(player.global_position).angle()
	print("engage_random_direction_movement")
	pass


	

func engage_side_to_side_movement():
	print("engage_side_to_side_movement")

	if player != null:
		# Calcular la dirección hacia el jugador
		actor.rotation = actor.global_position.direction_to(player.global_position).angle()
		var player_direction = global_position.direction_to(player.global_position).normalized()

		# Calcular el vector perpendicular para el movimiento de lado a lado
		var side_to_side_direction = Vector2(-player_direction.y, player_direction.x)

		# Girar hacia la posición del jugador
		actor.rotation = actor.global_position.direction_to(player.global_position).angle()

		# Mover al enemigo de izquierda a derecha (o viceversa) de manera rápida
		var speed_multiplier = 2.0  # Puedes ajustar este valor según la velocidad deseada
		actor.move_and_slide(side_to_side_direction * speed * speed_multiplier)
	else:
		print("Error: No hay jugador para seguir")
		

func initialize(actor, weapon: Weapon):
	self.actor = actor
	self.weapon = weapon	
	

func set_state(new_state: int):
	if new_state == current_state:
		return 	
	current_state = new_state
	emit_signal("state_changed", current_state)

func set_move_state(new_state: int):
	pass

func handle_reload():
	weapon.start_reload()
	

func _on_PlayerDetection_body_entered(body):
	if body.is_in_group("player"):
		set_state(State.ENGAGE)
		player = body 
