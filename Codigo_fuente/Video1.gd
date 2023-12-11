extends Node2D

onready var transition = $AnimationPlayer
onready var label1 = $Label1
onready var label2 = $Label2
onready var label3 = $Label3
onready var label4 = $Label4
onready var label5 = $Label5
onready var label6 = $Label6
onready var label7 = $Label7
onready var label8 = $Label8

onready var timer1 = $Timer1
onready var timer2 = $Timer2
onready var timer3 = $Timer3
onready var timer4 = $Timer4
onready var timer5 = $Timer5
onready var timer6 = $Timer6
onready var timer7 = $Timer7
onready var timer8 = $Timer8
onready var timer9 = $Timer9
onready var timer10 = $Timer10
onready var timer11 = $Timer11
onready var videoPlayer = $VideoPlayer


func _ready():
	label1.show()
	label2.hide()
	timer1.start()	
	$ColorRect.hide()
			
		
func _on_VideoPlayer_finished():
	get_tree().change_scene("res://Main.tscn")	


func _on_Button_pressed():
	$ColorRect.show()
	transition.play("Transition")

func _on_animation_end():	
	get_tree().change_scene("res://Main.tscn")	


func _on_Timer1_timeout():
	label1.hide()
	timer2.start()

func _on_Timer2_timeout():
	label2.show()
	timer3.start()
	
func _on_Timer3_timeout():
	label2.hide()
	timer4.start()
	
func _on_Timer4_timeout():
	label3.show()
	timer5.start()

func _on_Timer5_timeout():
	label3.hide()
	timer6.start()
	label4.show()
	
func _on_Timer6_timeout():
	label4.hide()
	timer7.start()
	label5.show()
	
func _on_Timer7_timeout():
	label5.hide()
	label6.show()
	timer8.start()

func _on_Timer8_timeout():
	label6.hide()
	label7.show()
	timer9.start()

func _on_Timer9_timeout():
	label7.hide()
	timer10.start()

func _on_Timer10_timeout():
	label8.show()
	timer11.start()

func _on_Timer11_timeout():
	label8.hide()
