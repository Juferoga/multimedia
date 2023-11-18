extends KinematicBody2D

onready var health_stat = $Health
onready var ia3 = $IA3
onready var team = $Team
onready var attack = $AttackZone
onready var attack_sound = $AttackSound
onready var attack_animation = $AnimationPlayer
onready var death_sound = $DeathSound
onready var sprite = $Sprite

onready var random_sound_timer = $RandomSoundTimer
onready var sound_effects = [$SoundEnemy1, $SoundEnemy2, $SoundEnemy3]



export (int) var damage = 100  
export (float) var attack_cooldown = 1.0

var attacking = false
var current_cooldown = 0.0
var targets = []
var is_diyng = false 


func _ready() -> void: 
	ia3.initialize(self)
	sprite.show()
	attack.connect("body_entered", self, "_on_AttackZone_body_entered")
	attack.connect("body_exited", self, "_on_AttackZone_body_exited")
	
	random_sound_timer.wait_time = rand_range(1, 5)  # Tiempo aleatorio entre 5 y 15 segundos
	random_sound_timer.start()
	random_sound_timer.connect("timeout", self, "_on_RandomSoundTimer_timeout")
	
	
func _on_RandomSoundTimer_timeout():
	if !is_any_sound_playing():
		var random_index = randi() % sound_effects.size()  # Seleccionar un índice aleatorio
		sound_effects[random_index].play()

	random_sound_timer.wait_time = rand_range(5, 10)  # Restablecer el temporizador para la próxima reproducción
	random_sound_timer.start()

func is_any_sound_playing() -> bool:
	for sound in sound_effects:
		if sound.playing:
			return true
	return false
	

func handle_hit():
	health_stat.health -= damage 
	if health_stat.health <= 0:
		is_diyng = true
		attack_animation.play("DeathAnimation")
		death_sound.play()
		

func _on_animation_finished():
	queue_free()

		
func hit():
	attack.monitoring = true

func end_of_hit():
	attack.monitoring = false

func _on_AttackZone_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		targets.append(body)
		attacking = true
		
		if current_cooldown <= 0.0:
			_attack()
		else:
			current_cooldown = attack_cooldown

func _on_AttackZone_body_exited(body: Node) -> void:
	if body.is_in_group("player") and targets.has(body):
		targets.erase(body)
		if targets.size() == 0:
			attacking = false
			current_cooldown = 0.0
			

func _attack() -> void:
	for target in targets:
		if target.has_method("handle_hit") and is_diyng != true:
			target.handle_hit()
			#Sonido
			attack_animation.play("AnimationAttack")
			attack_sound.play()
			
			
			
	current_cooldown = attack_cooldown

func _process(delta: float) -> void:
	if attacking and current_cooldown > 0.0:
		current_cooldown -= delta
	else:
		if attacking:
			_attack()

func get_team() -> int:
	return team.team
