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
	var hotspot = Vector2(yellow_1.get_width() / 2, yellow_1.get_height() / 2)
	Input.set_custom_mouse_cursor(yellow_1, Input.CURSOR_ARROW, hotspot)

func _on_Yellow_2_pressed():
	$Selection.play()
	var hotspot = Vector2(yellow_2.get_width() / 2, yellow_2.get_height() / 2)
	Input.set_custom_mouse_cursor(yellow_2, Input.CURSOR_ARROW, hotspot)


func _on_Yellow_3_pressed():
	$Selection.play()
	var hotspot = Vector2(yellow_3.get_width() / 2, yellow_3.get_height() / 2)
	Input.set_custom_mouse_cursor(yellow_3, Input.CURSOR_ARROW, hotspot)


func _on_Yellow_4_pressed():
	$Selection.play()
	var hotspot = Vector2(yellow_4.get_width() / 2, yellow_4.get_height() / 2)
	Input.set_custom_mouse_cursor(yellow_4, Input.CURSOR_ARROW, hotspot)


func _on_Yellow_5_pressed():
	$Selection.play()
	var hotspot = Vector2(yellow_5.get_width() / 2, yellow_5.get_height() / 2)
	Input.set_custom_mouse_cursor(yellow_5, Input.CURSOR_ARROW, hotspot)


func _on_Yellow_6_pressed():
	$Selection.play()
	var hotspot = Vector2(yellow_6.get_width() / 2, yellow_6.get_height() / 2)
	Input.set_custom_mouse_cursor(yellow_6, Input.CURSOR_ARROW, hotspot)


func _on_Yellow_7_pressed():
	$Selection.play()
	var hotspot = Vector2(yellow_7.get_width() / 2, yellow_7.get_height() / 2)
	Input.set_custom_mouse_cursor(yellow_7, Input.CURSOR_ARROW, hotspot)


func _on_Yellow_8_pressed():
	$Selection.play()
	var hotspot = Vector2(yellow_8.get_width() / 2, yellow_8.get_height() / 2)
	Input.set_custom_mouse_cursor(yellow_8, Input.CURSOR_ARROW, hotspot)


func _on_Documentation_pressed():
	$Selection.play()
	var url = "https://www.youtube.com/shorts/ee8eLg1r1vo"  
	OS.shell_open(url)
