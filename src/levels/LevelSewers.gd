extends "res://levels/Level.gd"


func _on_BarrelWithInstrument_first_opened():
	$Player.input_vec = Vector2()
	$Player.is_playable = false

	yield(get_tree().create_timer(0.5), "timeout")
	Globals.dialog_box.start_dialog([
		{ "name": "Super Note", "portrait": "sn_smile", "message": "Finally, instruments. I can \"talk\" now.",  },
		{ "name": "Super Note", "portrait": "sn_squint", "message": "They're a bit old though. I'd say they're about..." },
		{ "name": "Super Note", "portrait": "sn_shock", "message": "200 years old!?" },
		{ "name": "Super Note", "portrait": "sn_worry", "message": "Is that really how long I was deactivated...?" },
		])
	yield(Globals.dialog_box, "dialog_ended")
	$Player.is_playable = true


func _on_WindowScene_body_entered(_body):
	$WindowScene.set_deferred("monitoring", false)
	$Player.input_vec = Vector2()
	$Player.is_playable = false
	yield(get_tree().create_timer(0.5), "timeout")
	$Player.input_vec = Vector2(0.5, -0.5)
	yield(get_tree().create_timer(1.0), "timeout")
	$Player.input_vec = Vector2()
	yield(get_tree().create_timer(0.6), "timeout")


	Globals.dialog_box.start_dialog([
		{ "name": "Super Note", "portrait": "sn_smile", "message": "Ahh, the light of Guirjule's Star.",  },
		{ "name": "Super Note", "portrait": "sn_squint", "message": "It's brighter than what I remember, though." },
		{ "name": "Super Note", "portrait": "sn_worry", "message": "From what little I can recall..." },
		{ "name": "Super Note", "portrait": "sn_worry", "message": "There's a supercomputer inside our sun." },
		{ "name": "Super Note", "portrait": "sn_squint", "message": "Maybe it's currently overheating... I hope not." },
		])
	yield(Globals.dialog_box, "dialog_ended")
	$Player.is_playable = true


func _on_ElekScene_body_entered(_body):
	$ElekScene.set_deferred("monitoring", false)
	$Player.input_vec = Vector2()
	$Player.is_playable = false
	$Player.input_vec = Vector2(-1.0, -0.5)
	yield(get_tree().create_timer(1.0), "timeout")
	$Player.input_vec = Vector2()


	Globals.dialog_box.start_dialog([
		{ "name": "Super Note", "portrait": "sn_shock", "message": "Dammit! The game isn't finished!",  },
		{ "name": "Super Note", "portrait": "sn_squint", "message": "Not even close." },
		{ "name": "Super Note", "portrait": "sn_squint", "message": "You know what you have to do." },
		])
	yield(Globals.dialog_box, "dialog_ended")
	$Player.is_playable = true
