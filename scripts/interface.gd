extends CanvasLayer


func _ready():
	pass

signal angle1_value_changed(value)
signal angle2_value_changed(value)
signal width_value_changed(value)


func _on_angle1_value_changed(value):
	emit_signal("angle1_value_changed", value)


func _on_angle2_value_changed(value):
	emit_signal("angle2_value_changed", value)


func _on_width_value_changed(value):
	emit_signal("width_value_changed", value)
