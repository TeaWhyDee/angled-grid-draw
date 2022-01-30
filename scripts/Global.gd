extends Node 

var drawing = false
var erasing = false

func _process(delta): 
	if Input.is_action_just_pressed("draw"):
		drawing = true
	elif Input.is_action_just_released("draw"):
		drawing = false

	if Input.is_action_just_pressed("erase"):
		erasing = true
	elif Input.is_action_just_released("erase"):
		erasing = false


