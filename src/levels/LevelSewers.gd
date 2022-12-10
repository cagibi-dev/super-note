extends "res://levels/Level.gd"


func _on_BarrelWithInstrument_first_opened():
	player_node.target_position = player_node.position
	player_node.is_playable = false

	await get_tree().create_timer(0.5).timeout
	Globals.dialog_system.start_dialog([
		{ "text": "With instruments, Super Note is able to communicate!", },
		{ "name": "Super Note", "portrait": "sn_smile", "text": "Ah, wood blocks. I can sort of talk now.",  },
		{ "name": "Super Note", "portrait": "sn_squint", "text": "They're a bit old though. I'd say they're about..." },
		{ "name": "Super Note", "portrait": "sn_shock", "text": "200 years old!?" },
		{ "name": "Super Note", "portrait": "sn_worry", "text": "Is that really how long I was deactivated...?" },
		])
	await Globals.dialog_system.dialog_ended
	Globals.play_music(preload("res://music/sewers.ogg"))
	player_node.is_playable = true


func _on_WindowScene_body_entered(_body):
	$WindowScene.set_deferred("monitoring", false)
	player_node.is_playable = false
	player_node.target_position = $WindowScene.position
	await get_tree().create_timer(1.5).timeout


	Globals.dialog_system.start_dialog([
		{ "name": "Super Note", "portrait": "sn_smile", "text": "Ahh, the light of Guirjule's Star.",  },
		{ "name": "Armonica", "portrait": "an_think", "text": "It's brighter than usual, though." },
		{ "name": "Super Note", "portrait": "sn_worry", "text": "From what little I can recall..." },
		{ "name": "Super Note", "portrait": "sn_worry", "text": "There's a supercomputer inside our sun." },
		{ "name": "Super Note", "portrait": "sn_squint", "text": "Maybe it's currently overheating..." },
		{ "name": "Armonica", "portrait": "an_neutral", "text": "Well I hope not!" },
		])
	await Globals.dialog_system.dialog_ended
	player_node.is_playable = true


func _on_ElekScene_body_entered(_body):
	$ElekScene.set_deferred("monitoring", false)
	player_node.is_playable = false
	player_node.target_position = $ElekScene.position
	await get_tree().create_timer(1.0).timeout


	Globals.dialog_system.start_dialog([
		{ "name": "Super Note", "portrait": "sn_shock", "text": "Dammit! The game isn't finished!",  },
		{ "name": "Super Note", "portrait": "sn_squint", "text": "Not even close." },
		{ "name": "Super Note", "portrait": "sn_squint", "text": "Developer. You know what you need to do." },
		])
	await Globals.dialog_system.dialog_ended
	player_node.is_playable = true
