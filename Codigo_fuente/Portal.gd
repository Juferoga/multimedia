extends Area2D

export (String) var scene


var var_base_captured = false
var base

func _ready():
	base = get_node("/root/Main/Base")
	if base != null:
		base.connect("base_captured", self, "active_portal")
	else:
		print("Node 'Base' not found.")
	
func _on_Portal_body_entered(body):
	#and var_base_captured == true
	if body.is_in_group("player") :
		#get_tree().change_scene("res://scene2.tscn")
		get_tree().change_scene("res://Video2.tscn")
		
func active_portal():
	var_base_captured = true
