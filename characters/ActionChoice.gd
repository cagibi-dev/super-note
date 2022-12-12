extends Control


# this script takes care of menu opening/closing and focus

func _on_Play_pressed():
	if $PlayChoice.visible:
		$PlayChoice.hide()
	else:
		$PlayChoice.show()
		$PlayChoice/Plays.get_child(0).grab_focus()
		$ActChoice.hide()
		$Inventory.hide()


func _on_Talk_pressed():
	if $ActChoice.visible:
		$ActChoice.hide()
	else:
		$ActChoice.show()
		$ActChoice/Actions.get_child(0).grab_focus()
		$PlayChoice.hide()
		$Inventory.hide()


func _on_Item_pressed():
	if $Inventory.visible:
		$Inventory.hide()
	else:
		$Inventory.show()
		$Inventory/Items.get_child(0).grab_focus()
		$PlayChoice.hide()
		$ActChoice.hide()


func _on_ActionChoice_visibility_changed():
	if visible:
		$Panel/Actions/Play.grab_focus()
	else:
		$PlayChoice.hide()
		$ActChoice.hide()
		$Inventory.hide()
