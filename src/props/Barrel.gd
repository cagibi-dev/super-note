extends "res://props/Interactable.gd"


export (String) var item := "CoolPotion"
export (int) var credits := 0


func _on_1_pressed():
	# open or close barrel
	menu_container_node.hide()

	if $Sprite.frame == 0:
		$Sprite.frame = 1
		if item != "":
			print("you got " + item)
			Globals.inventory.append(item)
			item = ""
		if credits > 0:
			print("you got credits")
			# TODO globals
			credits = 0
		actions_node.get_child(0).text = "Close"
	else:
		$Sprite.frame = 0
		actions_node.get_child(0).text = "Open"
