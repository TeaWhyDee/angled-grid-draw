extends Node 


func _ready(): 
	var t = Config.settings["defaults"]["autosave_period"]

	var timer = Timer.new()
	timer.wait_time = t
