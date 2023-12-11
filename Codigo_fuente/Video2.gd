extends Node2D

func _ready():
	$Timer.start()
	$Label1.hide()

func _on_VideoPlayer_finished():
	get_tree().change_scene("res://scene2.tscn")	


func _on_Timer_timeout():
	$Label1.show()
	$Timer2.start()


func _on_Timer2_timeout():
	$Label1.hide()
	
