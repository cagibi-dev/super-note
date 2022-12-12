extends "res://props/interactable.gd"

signal first_opened

@export var item: Item = null
@export var money := 0


func say(line: Dictionary):
	await get_tree().create_timer(0.5).timeout

	Globals.dialog_system.start_dialog([line])
	await Globals.dialog_system.dialog_ended
	interactor.is_playable = true
	emit_signal("first_opened")


func _on_1_pressed():
	interactor.target_position = interactor.position
	interactor.is_playable = false

	# open or close barrel
	menu_container_node.hide()

	if $Sprite2D.frame == 0:
		# Open
		$Sprite2D.frame = 1
		$Open.play()
		await get_tree().create_timer(0.5).timeout
		actions_node.get_child(0).text = "Close"

		if item != null:
			$Item.play()
			say({ "text": "You found %s!" % item.name })
			Globals.add_to_inventory(item)
			item = null
		elif money > 0:
			$Coins.play()
			say({ "text": "You found %s sonats!" % money })
			Globals.money += money
			money = 0
		else:
			interactor.is_playable = true
	else:
		# Close
		$Sprite2D.frame = 0
		$Close.play()
		await get_tree().create_timer(0.5).timeout
		interactor.is_playable = true
		actions_node.get_child(0).text = "Open"
