extends Control

export var p1 = Vector2(500,500)
export var p2 = Vector2(600,500)
export var p3 = Vector2(600,700)
export var p4 = Vector2(500,700)

func _ready():
	var points : PoolVector2Array = PoolVector2Array([p1, p2, p3, p4])
	var unit = preload("res://scenes/unit.tscn")
	var unit1 = unit.instance()
	add_child(unit1)
	unit1.create(points)

