extends Node2D

var blue_1 = preload("res://Assets/Crosshair/Blue_1.png")

var yellow_1 = preload("res://Assets/Crosshair/Yellow/1.png")
var yellow_2 = preload("res://Assets/Crosshair/Yellow/4.png")
var yellow_3 = preload("res://Assets/Crosshair/Yellow/6.png")
var yellow_4 = preload("res://Assets/Crosshair/Yellow/17.png")
var yellow_5 = preload("res://Assets/Crosshair/Yellow/20.png")
var yellow_6 = preload("res://Assets/Crosshair/Yellow/22.png")
var yellow_7 = preload("res://Assets/Crosshair/Yellow/28.png")
var yellow_8 = preload("res://Assets/Crosshair/Yellow/40.png")



func _on_TextureButton_pressed():
	$Selection.play()
	Input.set_custom_mouse_cursor(blue_1)
	
		
	
func _on_Volver_pressed():
	$Selection.play()
	get_tree().change_scene("res://MenuPrincipal.tscn")


func _on_Yellow_1_pressed():
	$Selection.play()
	Input.set_custom_mouse_cursor(yellow_1)


func _on_Yellow_2_pressed():
	$Selection.play()
	Input.set_custom_mouse_cursor(yellow_2)


func _on_Yellow_3_pressed():
	$Selection.play()
	Input.set_custom_mouse_cursor(yellow_3)


func _on_Yellow_4_pressed():
	$Selection.play()
	Input.set_custom_mouse_cursor(yellow_4)


func _on_Yellow_5_pressed():
	$Selection.play()
	Input.set_custom_mouse_cursor(yellow_5)


func _on_Yellow_6_pressed():
	$Selection.play()
	Input.set_custom_mouse_cursor(yellow_6)


func _on_Yellow_7_pressed():
	$Selection.play()
	Input.set_custom_mouse_cursor(yellow_7)


func _on_Yellow_8_pressed():
	$Selection.play()
	Input.set_custom_mouse_cursor(yellow_8)
