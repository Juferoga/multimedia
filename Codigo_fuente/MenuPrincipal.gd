extends Node2D

onready var boton = $Button

func _ready():
	boton.connect("pressed", self, "_on_button_pressed")


func _on_button_pressed():
	get_tree().change_scene("res://Main.tscn")
