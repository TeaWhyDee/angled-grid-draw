extends Area2D

signal updated(status)

onready var collision = $Collision
onready var polygon_hover = $CollisionPolygon
onready var polygon = $Polygon

var color_polygon_hover = Color(0.5, 0.5, 1, 0.5)
var color_polygon = Color(1, 1, 1, 1)

var enabled = false 

# func _ready():
# 	var p1 = Vector2(500,500)
# 	var p2 = Vector2(600,500)
# 	var p3 = Vector2(600,700)
# 	var p4 = Vector2(500,700)
	# var points : PoolVector2Array = PoolVector2Array([p1, p2, p3, p4])
	# create(points)


func create(points: PoolVector2Array, points_hover: PoolVector2Array):
	polygon.polygon = points
	collision.polygon = points_hover
	polygon_hover.polygon = points_hover
	polygon_hover.color = color_polygon_hover


func _on_unit_mouse_entered():
	polygon_hover.visible = true


func _on_unit_mouse_exited():
	polygon_hover.visible = false


func _on_unit_input_event(viewport, event, shape_idx):
	if Global.drawing && enabled == false:
		enabled = true
		polygon.visible = true
		emit_signal("updated", true)
	if Global.erasing && enabled == true:
		enabled = false
		polygon.visible = false
		emit_signal("updated", false)
