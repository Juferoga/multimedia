extends Node2D

class_name Weapon

signal weapon_out_of_ammmo
signal reload_started
signal reload_finished

export (PackedScene) var Bullet 

var team: int = -1
var max_ammo: int = 10
var current_ammo: int = max_ammo


onready var end_of_gun = $EndOfGun
onready var gun_direction = $GunDirection
onready var attack_cooldown = $AttackCooldown
onready var animation_player = $AnimationPlayer
onready var gun_flash = $GunFlash


func _ready() -> void: 
	gun_flash.hide()
	current_ammo = max_ammo
	

func initialize(team: int):
	self.team = team

func start_reload():
	emit_signal("reload_started")
	animation_player.play("Reload")

func _stop_reload():
	current_ammo = max_ammo
	emit_signal("reload_finished")

func shoot():
	if current_ammo != 0 and attack_cooldown.is_stopped() and Bullet	 != null:	
		var bullet_instance = Bullet.instance()
		var direction = (gun_direction.global_position - end_of_gun.global_position).normalized()
		GlobalSignals.emit_signal("bullet_fired", bullet_instance, team,  end_of_gun.global_position, direction)
		attack_cooldown.start()
		animation_player.play("GunFlash")
		current_ammo -= 1
		if current_ammo == 0:
			emit_signal("weapon_out_of_ammo")
			
