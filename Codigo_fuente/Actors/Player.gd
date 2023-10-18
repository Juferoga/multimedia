extends KinematicBody2D

class_name Player



export (int) var speed = 250

onready var weapon: Weapon = $Weapon
onready var health_stat = $Health
onready var team = $Team

func _ready():
	weapon.initialize(team.team)

#Función que es llamada cada frame
func _physics_process(delta: float) -> void:
	var movement_direction := Vector2.ZERO	
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
	if event.is_action_pressed("shoot"):
		weapon.shoot()

	
func handle_hit():
	health_stat.health -= 20
	if health_stat.health <= 0:
		self.visible = false  # Desactiva el renderizado del enemigo
		self.collision_layer = 0  # Deshabilita la colisión del enemigo
		self.collision_mask = 0
			
func get_team() -> int:
	return team.team
	
		
	
	
	
	
	
	
		
	
