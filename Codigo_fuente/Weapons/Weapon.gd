extends Node2D

class_name Weapon


signal reload_started
signal reload_finished

export (PackedScene) var Bullet 
export (PackedScene) var BulletBoss


 

var team: int = -1
var max_ammo: int = 10
var current_ammo: int = max_ammo
var player_position

var is_connected_boss = false


onready var end_of_gun = $EndOfGun
onready var gun_direction = $GunDirection
onready var attack_cooldown = $AttackCooldown
onready var animation_player = $AnimationPlayer
onready var gun_flash = $GunFlash
onready var gun_reload_sound = $GunReloadSound
onready var gun_shoot = $GunShoot



func _ready() -> void: 
	gun_flash.hide()
	current_ammo = max_ammo
	
	
	
	

func initialize(team: int):
	self.team = team

func start_reload(is_boss: bool):
	emit_signal("reload_started")
	#print("Reload")
	animation_player.play("Reload")
	if !is_boss:
		gun_reload_sound.play()
	
	

func _stop_reload():
	current_ammo = max_ammo
	emit_signal("reload_finished")

func shoot(is_player: bool, is_boss: bool):
	var bullet_instance
	var final_boss_node
	if current_ammo != 0 and attack_cooldown.is_stopped() and (Bullet != null or BulletBoss != null):			
		if !is_boss:
			bullet_instance = Bullet.instance()
			gun_shoot.play()
		else: 
			if !is_connected_boss:
				is_connected_boss = true
				final_boss_node = get_parent() 
				final_boss_node.connect("set_fase", self, "_fase_state")
						
			bullet_instance = BulletBoss.instance()
			$BossShoot.play()
			
		var direction = (gun_direction.global_position - end_of_gun.global_position).normalized()
		GlobalSignals.emit_signal("bullet_fired", bullet_instance, team,  end_of_gun.global_position, direction)
		attack_cooldown.start()
		animation_player.play("GunFlash")
		#print("Gunshoot") #Aqui deberia ir el sondo supongo lptm
		
		current_ammo -= 1	
	elif current_ammo == 0 and attack_cooldown.is_stopped() and is_player: 
		$EmptyGun.play()
		 
func _fase_state(health: int):
	if health == 76:
		attack_cooldown.wait_time = 0.4
	elif health == 50:
		max_ammo = 15	
		attack_cooldown.wait_time = 0.3
	elif health == 26:
		max_ammo = 20
		attack_cooldown.wait_time = 0.2
