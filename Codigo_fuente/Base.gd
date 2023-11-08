extends Area2D

var base_color = Color(0.443137, 0.870588, 0.117647)
var neutral_color = Color(1, 1, 1)

onready var base_timer = $BaseTimer
onready var sprite = $Sprite
onready var captured_sound = $CaputreBaseSound

var stored_time = 0.0
var in_zone = false
var init_time = 0.0
var seconds_change_difficulty_interval = 30
var seconds_change_difficulty_total = seconds_change_difficulty_interval

signal change_difficulty
signal base_captured

func _ready():
	pass

func _on_Base_body_entered(body):
	if body.is_in_group("player"):
		in_zone = true
		if stored_time > 0.0:
			base_timer.start(stored_time)
			#stored_time = 0.0
		else:
			base_timer.start() 
			init_time = base_timer.time_left
						

func _on_Base_body_exited(body):
	if body.is_in_group("player"):
		in_zone = false
		stored_time = base_timer.time_left
		base_timer.stop() 

func _on_BaseTimer_timeout():
	sprite.modulate = base_color
	base_timer.stop()
	captured_sound.playing = true
	emit_signal("base_captured")


var tiempoantes = 0
var tiempoahora  = 0
	
	
#Imprime en consola el tiempo (Es para la GUI alguna lógica así seguramente)
func _process(delta: float) -> void:
	
	
	tiempoahora = round(base_timer.time_left)
	
	var rounded_base_timer = round(base_timer.time_left)
	var rounded_init_time = round(init_time)
	
	if rounded_init_time - seconds_change_difficulty_total == rounded_base_timer and rounded_init_time - seconds_change_difficulty_total != 0:
		seconds_change_difficulty_total += seconds_change_difficulty_interval
		emit_signal("change_difficulty", rounded_base_timer)
		
	
	if tiempoahora != tiempoantes and tiempoahora != 0:
		#print(tiempoahora)
		#var comparison_string = str(rounded_init_time) + " - " + str(seconds_change_difficulty_total) + " == " + str(rounded_base_timer)
		#print(comparison_string)
		tiempoantes = tiempoahora
	
	
	#if in_zone and base_timer.time_left > 0:
	#	print(base_timer.time_left)
	
	
		

	
 


