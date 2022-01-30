extends OptionButton


func _ready():
	add_item("Left Panel")
	add_item("Right Panel")
	add_item("Left Panel")
	for i in get_item_count():
		get_popup().set_item_as_radio_checkable(i, false)
		get_popup().set_item_as_checkable(i, true)
