extends "res://characters/EncounterCharacter.gd"


onready var anim_node: AnimationPlayer = $Anim


func _ready():
	$HUD/ActionChoice.rect_position = global_position
	refresh_inventory()


func refresh_inventory():
	var container: Control = $HUD/ActionChoice/Inventory/Items
	var template: BaseButton = container.get_child(0)
	for old_child in container.get_children():
		if old_child != template:
			old_child.queue_free()

	var i := 0
	for item in Globals.inventory:
		var item_button := template.duplicate()
		item_button.text = item
		item_button.show()
		item_button.connect("pressed", self, "_on_item_chosen", [ i ])
		i += 1
		container.add_child(item_button)


func set_vibe(new_vibe: int):
	if anim_node:
		if new_vibe < vibe:
			anim_node.play("hurt")
		else:
			anim_node.play("heal")

		if new_vibe <= 0:
			# Stop fighting
			anim_node.play("die")
			remove_from_group("hero_alive")
			$Vibe.hide()

	.set_vibe(new_vibe)


func _on_turn():
	$Anim.play("choose" if vibe > 0 else "choose_dead")
	# display action choices
	$HUD/ActionChoice.show()


func _on_SoloImpro_pressed():
	# make selection of every actor alive
	$HUD/BackPanel.show()
	$HUD/Info.text = "Solo Impro: raise the Vibe of one person."
	$HUD/ActionChoice.hide()
	var actors := get_tree().get_nodes_in_group("enemy_alive")
	actors.append_array(get_tree().get_nodes_in_group("hero_alive"))
	for actor in actors:
		var sel := $Selectable.duplicate()
		sel.show()
		sel.position = actor.global_position - global_position
		sel.get_child(0).text = actor.actor_name
		sel.get_child(1).connect("pressed", self, "solo_impro", [ actor ])
		$Selectables.add_child(sel)


func solo_impro(actor: EncounterCharacter):
	for selectable in $Selectables.get_children():
		selectable.queue_free()
	$HUD/BackPanel.hide()
	$HUD/Info.text = ""

	anim_node.play("play")
	yield(anim_node, "animation_finished")

	var dmg: int = min_atk + randi() % atk_rand_range
	actor.vibe += dmg
	spawn_number(actor.position, dmg)
	yield(actor, "finished_reacting")

	emit_signal("finished_acting")


func _on_Back_pressed():
	for selectable in $Selectables.get_children():
		selectable.queue_free()
	$HUD/BackPanel.hide()
	$HUD/Info.text = ""
	$HUD/ActionChoice.show()


func _on_Song_pressed():
	pass # Replace with function body.


func _on_Check_pressed():
	pass # Replace with function body.


func _on_Scare_pressed():
	pass # Replace with function body.


func _on_item_chosen(index: int):
	$HUD/ActionChoice.hide()

	# consume item
	# TODO fix item shifting
	var item: String = Globals.inventory.pop_at(index)
	$HUD/ActionChoice/Inventory/Items.get_child(index + 1).queue_free()
	# USE ITEM
	if item == "CoolPotion":
		spawn_number(position, 8, true)
		set_vibe(vibe + 8)
		yield(anim_node, "animation_finished")
	emit_signal("finished_acting")
	refresh_inventory()


func _on_Anim_animation_finished(_anim_name: String):
	if not is_alive():
		anim_node.play("dead")
	else:
		anim_node.play("idle")
	emit_signal("finished_reacting")


func victory_pose():
	anim_node.play("victory")
