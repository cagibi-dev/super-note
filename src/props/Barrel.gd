extends "res://props/Interactable.gd"

signal first_opened

export (String) var item := "CoolPotion"
export (int) var money := 0



func say(line: Dictionary):
	yield(get_tree().create_timer(0.5), "timeout")

	Globals.dialog_system.start_dialog([line])
	yield(Globals.dialog_system, "dialog_ended")
	interactor.is_playable = true
	emit_signal("first_opened")


func _on_1_pressed():
	interactor.target_position = interactor.position
	interactor.is_playable = false

	# open or close barrel
	menu_container_node.hide()

	if $Sprite.frame == 0:
		# Open
		$Sprite.frame = 1
		$Open.play()
		yield(get_tree().create_timer(0.5), "timeout")
		actions_node.get_child(0).text = "Close"

		if item != "":
			$Item.play()
			say({ "text": "You found %s!" % item })
			Globals.add_to_inventory(item)
			item = ""
		elif money > 0:
			$Coins.play()
			say({ "text": "You found %s sonats!" % money })
			Globals.money += money
			money = 0
		else:
			interactor.is_playable = true
	else:
		# Close
		$Sprite.frame = 0
		$Close.play()
		yield(get_tree().create_timer(0.5), "timeout")
		interactor.is_playable = true
		actions_node.get_child(0).text = "Open"
