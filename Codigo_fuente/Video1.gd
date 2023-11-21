extends Node2D

onready var transition = $AnimationPlayer

func _ready():
	$ColorRect.hide()
	
func _on_VideoPlayer_finished():
	get_tree().change_scene("res://Main.tscn")	


func _on_Button_pressed():
	$ColorRect.show()
	transition.play("Transition")


func _on_animation_end():	
	get_tree().change_scene("res://Main.tscn")	
