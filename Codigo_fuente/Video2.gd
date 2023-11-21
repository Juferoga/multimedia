extends Node2D

func _ready():
	pass # Replace with function body.


func _on_VideoPlayer_finished():
	get_tree().change_scene("res://scene2.tscn")	
