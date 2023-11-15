extends Node

# Variables para almacenar los datos del jugador
var player_health = 100
var current_lives = 3

	
func set_lives(lives: int):
	current_lives = lives
		

func set_health(health: int):
	player_health = health
	print("Vida actual: ", health)

func reset_data():
	player_health = 100
	current_lives = 3
