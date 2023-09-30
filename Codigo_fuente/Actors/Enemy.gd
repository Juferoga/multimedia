extends KinematicBody2D

onready var health_stat = $Health
onready var ia = $IA
onready var weapon = $Weapon


func _ready() -> void: 
	ia.initialize(self, weapon)

func handle_hit():
	health_stat.health -= 20
	if health_stat.health <= 0:
		queue_free()
