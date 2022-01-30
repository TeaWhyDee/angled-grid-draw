extends Control

var unit = preload("res://scenes/unit.tscn")
var unit_matrix = []

var start_pos = Vector2(5000, 5000)
var grid_size = 50.0
var line_size = 50.0
var color_grid = Color(1,1,1,0.5)
onready var width = Config.settings["defaults"]["linewidth"]
onready var width_grid = Config.settings["defaults"]["linewidth_grid"]
onready var editor_focus_length = Config.settings["editor"]["editor_focus_length"]
onready var editor_focus_width = Config.settings["editor"]["editor_focus_width"]
onready var angle1 = Config.settings["defaults"]["angle1"]
onready var angle2 = Config.settings["defaults"]["angle2"]

onready var units = get_parent().get_node("units")
onready var interface = get_parent().get_node("Interface")


func get_shape(starting_point: Vector2, offset1: Vector2, \
		offset2: Vector2, this_width: float, offset_multiplier: float):
	var point = starting_point
	var points:= PoolVector2Array()
	points.append(point 
		- offset1.normalized() * this_width / 2 * offset_multiplier
		- offset2.normalized() * this_width / 2)
	points.append(point 
		- offset1.normalized() * this_width / 2 * offset_multiplier
		+ offset2.normalized() * this_width / 2)
	points.append(point + offset1 
		+ offset1.normalized() * this_width / 2 * offset_multiplier
		+ offset2.normalized() * this_width / 2)
	points.append(point + offset1 
		+ offset1.normalized() * this_width / 2 * offset_multiplier
		- offset2.normalized() * this_width / 2)
	return points


func add_unit_n_grid(point, offset1, offset2, color, pos):
	var lines_grid = get_shape(point, offset1, offset2, width_grid, 0)
	var lines_units = get_shape(point - start_pos, offset1, offset2, editor_focus_width, -1)
	var lines = get_shape(point - start_pos, offset1, offset2, width, 1)
	# print(lines)
	draw_polygon(lines_grid, color)
	if unit_matrix[pos.x][pos.y][pos.z] == null:
		var thisunit = unit.instance()
		units.add_child(thisunit)
		thisunit.create(lines, lines_units)
		unit_matrix[pos.x][pos.y][pos.z] = thisunit
	else:
		unit_matrix[pos.x][pos.y][pos.z].create(lines, lines_units)


func _ready():
	unit_matrix = [[], []]
	var offset1 = line_size * Vector2(cos(deg2rad(angle1)), sin(deg2rad(angle1)))
	var offset2 = line_size * Vector2(cos(deg2rad(angle2)), sin(deg2rad(angle2)))
	print(offset1, " ", offset2)
	get_parent().get_node("Camera").position += Vector2(0, (offset1.y + offset2.y) * 10)
	for i in [0,1]:
		for x in range(grid_size+1):
			var col = []
			col.resize(grid_size+1)
			unit_matrix[i].append(col)
	update()


func _process(delta):
	if Input.is_action_just_pressed("save"):
		visible = false
		interface.get_node("settings").visible = false
		yield(VisualServer, 'frame_post_draw')
		var image = get_viewport().get_texture().get_data()
		image.flip_y()
		image.save_png("/home/tea/screenshot.png")

		visible = true
		# TODO: CHANGE THIS
		interface.get_node("settings").visible = true


func _draw():
	var offset1 = line_size * Vector2(cos(deg2rad(angle1)), sin(deg2rad(angle1)))
	var offset2 = line_size * Vector2(cos(deg2rad(angle2)), sin(deg2rad(angle2)))

	var point1 = start_pos
	var point2 = start_pos
	var colors = PoolColorArray()
	colors.append(color_grid)
	for i in range(grid_size+1):
		for j in range(grid_size):
			add_unit_n_grid(point1, offset1, offset2, colors, Vector3(0, i, j))
			add_unit_n_grid(point2, offset2, offset1, colors, Vector3(1, i, j))
			point1 = point1 + offset1
			point2 = point2 + offset2
		point1 = start_pos + offset2 * (i+1)
		point2 = start_pos + offset1 * (i+1)


func _on_Interface_width_value_changed(value):
	width = value
	update()


func _on_Interface_angle1_value_changed(value):
	angle1 = value
	update()

func _on_Interface_angle2_value_changed(value):
	angle2 = value
	update()
