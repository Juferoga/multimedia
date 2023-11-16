extends Node2D



func _on_Volver_pressed():
	$Selection.play()
	get_tree().change_scene("res://MenuPrincipal.tscn")
