extends Node2D

onready var transition = $AnimationPlayer
var yellow_5 = preload("res://Assets/Crosshair/Yellow/20.png")

var btnPlay = false
var btnLogros = false
var btnGuia = false 
var btnMiras = false
var btnCreditos = false

func _ready():
	if MUSICMENU.is_playing == false:
		MUSICMENU.play_music()
	$ColorRect.hide()
	var hotspot = Vector2(yellow_5.get_width() / 2, yellow_5.get_height() / 2)
	Input.set_custom_mouse_cursor(yellow_5, Input.CURSOR_ARROW, hotspot)


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
	
func _on_Crosshair_pressed():
	btnMiras = true
	$Selection.play()
	$ColorRect.show()
	transition.play("Transition")

	
func _on_Creditos_pressed():
	btnCreditos = true
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
	elif btnMiras: 
		get_tree().change_scene("res://Crosshair.tscn")
	elif btnCreditos: 
		get_tree().change_scene("res://Creditos.tscn")
	
		
	btnPlay = false
	btnLogros = false
	btnGuia = false 
	btnMiras = false
	btnCreditos = false
		
