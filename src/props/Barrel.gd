extends "res://props/Interactable.gd"

signal first_opened

export (String) var item := "CoolPotion"
export (int) var money := 0


func say(line: String):
	interactor.input_vec = Vector2()
	interactor.is_playable = false
	Globals.dialog_box.start_dialog([line])
	yield(Globals.dialog_box, "dialog_ended")
	interactor.is_playable = true
	emit_signal("first_opened")


func _on_1_pressed():
	# open or close barrel
	menu_container_node.hide()

	if $Sprite.frame == 0:
		$Sprite.frame = 1
		if item != "":
			say("You found %s!" % item)
			Globals.inventory.append(item)
			item = ""
		if money > 0:
			say("You found %s sonats!" % money)
			Globals.money += money
			money = 0
		actions_node.get_child(0).text = "Close"
	else:
		$Sprite.frame = 0
		actions_node.get_child(0).text = "Open"
