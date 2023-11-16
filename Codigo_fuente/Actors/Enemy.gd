extends KinematicBody2D

onready var health_stat = $Health
onready var ia = $IA
onready var weapon: Weapon = $Weapon
onready var team = $Team
onready var attack_animation = $AnimationPlayer
onready var death_sound = $DeathSound2


var is_diyng = false 
var is_reloading = false

signal reloading_changed

func _ready() -> void: 
	ia.initialize(self, weapon)
	weapon.initialize(team.team)
	weapon.connect("reload_started", self, "_on_reload_started")
	weapon.connect("reload_finished", self, "_on_reload_finished")

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
	
func _on_reload_started():
	is_reloading = true
	#emit_signal("reloading_changed", is_reloading)

func _on_reload_finished():
	is_reloading = false
	#emit_signal("reloading_changed", is_reloading)
