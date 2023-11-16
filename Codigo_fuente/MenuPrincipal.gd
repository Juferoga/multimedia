extends Node2D

onready var transition = $AnimationPlayer

var btnPlay = false
var btnLogros = false
var btnGuia = false 

func _ready():
	if MUSICMENU.is_playing == false:
		MUSICMENU.play_music()
	$ColorRect.hide()


func _on_LogrosBtn2_pressed():
	btnGuia = true
	$Selection.play()
	$ColorRect.show()
	transition.play("Transition")


func _on_JugarBtn_pressed():
	MUSICMENU.stop_music()
	btnPlay = true
	$Selection.play()
	$ColorRect.show()
	transition.play("Transition")


func _on_LogrosBtn_pressed():
	btnLogros = true
	$Selection.play()
	$ColorRect.show()
	transition.play("Transition")
	

func _on_animation_end():	
	if btnPlay: 
		get_tree().change_scene("res://Main.tscn")		
	elif btnGuia:
		get_tree().change_scene("res://Guia.tscn")
		
	elif btnLogros:
		get_tree().change_scene("res://Logros.tscn")
		print("Debe")
	btnPlay = false
	btnLogros = false
	btnGuia = false 

		
	
