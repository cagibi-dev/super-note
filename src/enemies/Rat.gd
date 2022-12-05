extends EncounterCharacter


onready var anim_node: AnimationPlayer = $Anim


func set_vibe(new_vibe: int):
	if anim_node:
		if new_vibe > vibe:
			anim_node.play("hurt")
		else:
			anim_node.play("heal")

		if new_vibe >= max_vibe:
			# Stop fighting
			remove_from_group("enemy_alive")
			anim_node.play("die")
			$Vibe.hide()

	.set_vibe(new_vibe)


func is_alive() -> bool:
	return vibe < max_vibe


func _on_turn():
	if not is_alive():
		emit_signal("finished_acting")
		return
	anim_node.play("attack")
	yield(anim_node, "animation_finished")

	# choose a random player to attack
	var heroes := get_tree().get_nodes_in_group("hero_alive")
	if len(heroes) > 0:
		var hero: EncounterCharacter = heroes[randi() % len(heroes)]
		var dmg: int = min_atk + randi() % atk_rand_range
		hero.vibe -= dmg
		spawn_number(hero.position, dmg)
		yield(hero, "finished_reacting")

	emit_signal("finished_acting")


func _on_Anim_animation_finished(_anim_name: String):
	if not is_alive():
		anim_node.play("dead")
	else:
		anim_node.play("idle")
	emit_signal("finished_reacting")
