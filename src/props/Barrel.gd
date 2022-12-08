extends "res://props/Interactable.gd"

signal first_opened

export (String) var item := "CoolPotion"
export (int) var money := 0



func say(line: Dictionary):
	interactor.input_vec = Vector2()
	interactor.is_playable = false
	yield(get_tree().create_timer(0.5), "timeout")

	Globals.dialog_box.start_dialog([line])
	yield(Globals.dialog_box, "dialog_ended")
	interactor.is_playable = true
	emit_signal("first_opened")


func _on_1_pressed():
	# open or close barrel
	menu_container_node.hide()

	if $Sprite.frame == 0:
		# Open
		$Sprite.frame = 1
		$Open.play()
		actions_node.get_child(0).text = "Close"

		if item != "":
			say({ "message": "You found %s!" % item })
			Globals.inventory.append(item)
			item = ""
			yield(self, "first_opened")
			$Item.play()
		elif money > 0:
			say({ "message": "You found %s sonats!" % money })
			Globals.money += money
			money = 0
			yield(self, "first_opened")
			$Coins.play()
	else:
		# Close
		$Sprite.frame = 0
		$Close.play()
		actions_node.get_child(0).text = "Open"
