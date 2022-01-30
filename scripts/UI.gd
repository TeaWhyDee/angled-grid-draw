extends Control


onready var left_panel: Button = get_node("Button")
onready var right_panel: Button = get_node("Button2")
onready var dropdown: PopupMenu = get_node("ViewButton").get_popup()


enum Panels {
	LEFT,
	RIGHT,
	BOTTOM,
	}

func _ready():
	dropdown.connect("id_pressed", self, "_on_id_pressed")
	dropdown.set_hide_on_checkable_item_selection(false)
	dropdown.add_check_item("Left Panel", Panels.LEFT)
	dropdown.set_item_checked(0, true)
	dropdown.add_check_item("Right Panel", Panels.RIGHT)
	dropdown.add_check_item("Bottom Panel", Panels.BOTTOM)
	# for i in get_popup().get_item_count():
	# 	get_popup().set_item_as_checkable(i, true)

func _on_id_pressed(id):
	var idx = dropdown.get_item_index(id)
	match (id):
		Panels.LEFT:
			if ( dropdown.is_item_checked(idx) ):
				left_panel.visible = false
			else:
				left_panel.visible = true
			dropdown.toggle_item_checked(idx)
		Panels.RIGHT:
			if ( dropdown.is_item_checked(idx) ):
				right_panel.visible = false
			else:
				right_panel.visible = true
			dropdown.toggle_item_checked(idx)
