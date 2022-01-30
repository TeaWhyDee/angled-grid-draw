tool
extends VBoxContainer

signal value_changed(value)

export var min_value = 0
export var max_value = 100
export var label = "slider"

onready var slider = $HSlider
onready var text = $Margin/HBox/text
onready var title = $Margin/HBox/Title

func _ready():
	if Engine.editor_hint:
		title.text = label
	title.text = label
	slider.min_value = min_value
	slider.max_value = max_value
	var value = slider.min_value
	if name in Config.settings["defaults"]:
		value = Config.settings["defaults"][name]
	else:
		print("ERROR: Default setting for " + name + " not found")
	slider.value = value
	text.text = String(value) 


func _on_HSlider_value_changed(value):
	text.text = String(slider.value)
	emit_signal("value_changed", value)


func _on_text_text_entered(new_text):
	if new_text.is_valid_integer():
		var value = int(new_text)
		value = clamp(value, min_value, max_value)
		slider.value = value
		emit_signal("value_changed", value)


func _on_Button_pressed():
	var value = slider.value
	print("saving new default for " + name + " : " + 
			String(value))
	Config.settings["defaults"][name] = value
	Config.save_config()
