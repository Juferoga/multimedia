extends Node2D

signal state_changed(new_state)


enum State {
	PATROL, 
	ENGAGE 
}

onready var player_detection = $PlayerDetection


var current_state: int  = State.PATROL setget set_state
var player: Player = null 
var weapon: Weapon = null
var actor = null

var movement_direction := Vector2.ZERO	
export (int) var speed = 200
export (int) var damage = 10


func _process(delta: float) -> void:
	match current_state:
		State.PATROL:
			pass
		State.ENGAGE:
			if player != null and actor.is_diyng == false:
				actor.rotation = actor.global_position.direction_to(player.global_position).angle()
				movement_direction = global_position.direction_to(player.global_position)
				movement_direction = movement_direction.normalized() 
				actor.move_and_slide(movement_direction * speed)
			else:
				#print("In the ENGAGE state but no weapon/players")
				pass
		_:
			print("Error: state enemy unknow")

func initialize(actor):
	self.actor = actor
	

func set_state(new_state: int):
	if new_state == current_state:
		return 
	
	current_state = new_state
	emit_signal("state_changed", current_state)


func _on_PlayerDetection_body_entered(body):
	if body.is_in_group("player"):
		set_state(State.ENGAGE)
		player = body 

