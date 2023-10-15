extends KinematicBody2D

onready var health_stat = $Health
onready var ia3 = $IA3

export (int) var melee_damage = 100  

func _ready() -> void: 
	ia3.initialize(self)

func handle_hit():
	health_stat.health -= melee_damage 
	if health_stat.health <= 0:
		queue_free()
