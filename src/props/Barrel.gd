extends "res://props/Interactable.gd"


export (String) var item := "CoolPotion"


func _on_1_pressed():
	# open or close barrel
	menu_container_node.hide()

	if $Sprite.frame == 0:
		$Sprite.frame = 1
		if item != "":
			print("you got " + item)
			Globals.inventory.append(item)
			item = ""
		actions_node.get_child(0).text = "Close"
	else:
		$Sprite.frame = 0
		actions_node.get_child(0).text = "Open"
