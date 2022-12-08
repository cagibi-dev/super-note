extends "res://levels/Level.gd"


func _on_BarrelWithInstrument_first_opened():
	$Player.input_vec = Vector2()
	$Player.is_playable = false
	Globals.dialog_box.start_dialog([
		"Finally, an instrument. I can talk now.",
		"It's not very shiny though. It looks about... 100 years old??",
		"How long have I been deactivated...?",
		])
	yield(Globals.dialog_box, "dialog_ended")
	$Player.is_playable = true
