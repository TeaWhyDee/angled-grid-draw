extends Node

var config_path = "user://config.txt"

signal setting_changed(section, setting, value)
# default settings, changed if the settings file exists/some script calls the "setting_changed" signal
var settings: Dictionary = {
	"defaults": {
		"angle1": 0.0,
		"angle2": 0.0,
		"linewidth": 20.0,
		"linewidth_grid": 2.0,
		"linewidth_unit": 15.0,
	},
	"shortcuts": {
		"pan": "mouse_middle",
	},
	"editor": {
		"editor_focus_length": 1.0,
		"editor_focus_width": 20.0,
	},
}
# normal config setup
var config = ConfigFile.new()
var err = config.load(config_path)

func _ready():
	connect("setting_changed", self, "_on_setting_changed")
	if err != OK:
		print("ERROR: loading config failed")
		return
	# loop through sections and keys, get the value if config exists
	for section in config.get_sections():
		if ! section in settings:
			print("ERROR: Config file has a non-existent section " + section)
			return
		for key in config.get_section_keys(section):
			if ! key in settings[section]:
				print("ERROR: Config file has a non-existent key " + key)
				return
			settings[section][key] = \
					config.get_value(section, key, settings[section][key])

func save_config():
	# loop through current settings, set values in the config file
	for section in settings.keys():
		for key in settings[section]:
			config.set_value(section, key, settings[section][key])
	config.save(config_path)

# change the current settings, gets called by other scripts (menu for example)
func _on_setting_changed(section, setting, value):
	settings[section][setting] = value

