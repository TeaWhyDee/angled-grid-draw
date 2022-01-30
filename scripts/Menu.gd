extends MenuButton

onready var popup_key: PopupMenu = get_node("PopupDialog")
var shortucts_n = 1


func _ready():
	pass # Replace with function body.


func _on_Menu_gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		match event.button_index:
			BUTTON_RIGHT:
				var pos_x = get_global_rect().position.x
				var pos_y = get_global_rect().end.y
				var size_x = 120
				var size_y = 80
				popup_key.popup(Rect2(pos_x, pos_y, size_x, size_y))
