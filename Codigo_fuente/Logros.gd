extends Node2D

onready var label_hell_king = $HellKing
onready var label_all_lifes = $AllLifes
onready var label_no_hit = $NoHit

func _ready():
	updateLabels()

func updateLabels():
	if ACHIEVEMENTS.hasAchievement("hell_king"):
		label_hell_king.text = "CONSEGUIDO"
		label_hell_king.modulate = Color(0, 0.5, 0)
	else:
		label_hell_king.text = "NO CONSEGUIDO"
		label_hell_king.modulate = Color(1, 0, 0) 

	if ACHIEVEMENTS.hasAchievement("all_lifes"):
		label_all_lifes.text = "CONSEGUIDO"
		label_all_lifes.modulate = Color(0, 0.5, 0)
	else:
		label_all_lifes.text = "NO CONSEGUIDO"
		label_all_lifes.modulate = Color(1, 0, 0) 

	if ACHIEVEMENTS.hasAchievement("no_hit"):
		label_no_hit.text = "CONSEGUIDO"
		label_no_hit.modulate = Color(0, 0.5, 0)
	else:
		label_no_hit.text = "NO CONSEGUIDO"
		label_no_hit.modulate = Color(1, 0, 0) 

func _on_Volver_pressed():
	$Selection.play()
	get_tree().change_scene("res://MenuPrincipal.tscn")
