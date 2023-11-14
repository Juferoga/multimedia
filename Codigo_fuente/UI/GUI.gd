extends CanvasLayer

# Verificamos que esten cargados los componentes
# Salud
onready var health_bar = $MarginContainer/Rows/BottomRow/HBoxContainer/HealtBar
# Armas
onready var current_ammo = $MarginContainer/Rows/BottomRow/HBoxContainer3/CurrentAmmo
onready var max_ammo = $MarginContainer/Rows/BottomRow/HBoxContainer3/MaxAmmo
# Vidas
onready var current_lifes = $MarginContainer/Rows/TopRow/HBoxContainer3/CurrentLifes
onready var max_lifes = $MarginContainer/Rows/TopRow/HBoxContainer3/MaxLifes
# Tiempo
onready var time_counter = $MarginContainer/Rows/TopRow/HBoxContainer/TimeCounter

var player: Player
var elapsed_time = 0  # Contador del tiempo transcurrido

func set_player(new_player:Player):
	self.player = new_player
	# Salud
	player.connect("player_health_changed", self, "set_new_health_value")
	# Armas
	player.connect("player_current_ammo_changed", self, "set_current_ammo")
	player.connect("player_max_ammo_changed", self, "set_current_ammo")
	# Vidas
	player.connect("player_current_lifes_changed", self, "set_current_lifes")
	player.connect("player_max_lifes_changed", self, "set_max_lifes")
	# Tiempo
	#player.connect("time_counter_changed", self, "set_time_counter")
	if player != null:
		player.emit_initial_signals()

func set_new_health_value(new_healht: int):
	health_bar.value = new_healht

func set_current_ammo(new_ammo: int):
	current_ammo.text = str(new_ammo)

func set_max_ammo(new_max_ammo: int):
	max_ammo.text = str(new_max_ammo)

func set_current_lifes(new_current_lifes):
	print("Estableciendo vidas")
	current_lifes.text = str(new_current_lifes)

func set_max_lifes(new_max_lifes):
	max_lifes.text = str(new_max_lifes)

func set_time_counter(new_time_counter):
	time_counter.text = str(new_time_counter)

func _on_Timer_timeout():
	elapsed_time += 1  # Aumentamos el contador en uno cada vez que se llama la función
	set_time_counter(elapsed_time)  # Actualizamos el contador en la UI
	
