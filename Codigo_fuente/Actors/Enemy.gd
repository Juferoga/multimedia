extends KinematicBody2D

onready var health_stat = $Health
onready var ia = $IA
onready var weapon: Weapon = $Weapon
onready var team = $Team


func _ready() -> void: 
	ia.initialize(self, weapon)
	weapon.initialize(team.team)

func handle_hit():
	health_stat.health -= 100
	if health_stat.health <= 0:
		queue_free()
	
func get_team() -> int:
	return team.team
