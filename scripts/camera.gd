extends Camera2D

var pan = false
var prev_mouse_pos = Vector2.ZERO
export var zoom_step = 0.12

func _ready():
	pass

func _process(_delta):
	var curr_zoom = zoom.x
	if Input.is_action_just_released("zoom_in"):
		var new_zoom = curr_zoom - zoom_step * (curr_zoom)
		new_zoom = clamp(new_zoom, 0.2, 4)
		zoom = Vector2(new_zoom, new_zoom)
	elif Input.is_action_just_released("zoom_out"):
		var new_zoom = curr_zoom + zoom_step * (curr_zoom)
		new_zoom = clamp(new_zoom, 0.2, 4)
		zoom = Vector2(new_zoom, new_zoom)
	if Input.is_action_pressed("pan"):
		pan = true 
		prev_mouse_pos = get_viewport().get_mouse_position()
	else:
		pan = false

func _input(event):
	if pan:
		if event is InputEventMouseMotion:
			position += (prev_mouse_pos - event.position)/2
			# print("Mouse Motion at: ", event.position)
