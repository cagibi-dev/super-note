extends Node2D


var actor_index := 0 # ID of the active hero or enemy
@export var is_enemys_turn := false


func _ready():
	for hero_index in range(len(Globals.party)):
		var hero: EncounterCharacter = Globals.party[hero_index]
		hero.position = $HeroPositions.get_child(hero_index).position
		$Heroes.add_child(hero)

		hero.connect("finished_acting",Callable(self,"_on_actor_finished_acting").bind( hero ))

	for enemy_index in range(len(Globals.encounter_data.enemies)):
		var enemy: EncounterCharacter = Globals.encounter_data.enemies[enemy_index]
		enemy.position = $EnemyPositions.get_child(enemy_index).position
		$Enemies.add_child(enemy)

		enemy.connect("finished_acting",Callable(self,"_on_actor_finished_acting").bind( enemy ))

	if is_enemys_turn:
		Globals.encounter_data.enemies[0]._on_turn()
	else:
		Globals.party[0]._on_turn()


func _exit_tree():
	# restore party vibe for next fight
	for p in Globals.party:
		if p.vibe <= 0:
			p.vibe = 1
	for hero in $Heroes.get_children():
		$Heroes.remove_child(hero)
	for enemy in $Enemies.get_children():
		$Enemies.remove_child(enemy)


func next_character():
	# wait for dead characters to disappear from the scene tree
	await get_tree().idle_frame

	if is_encounter_over():
		await get_tree().create_timer(2.0).timeout
		# TODO get out
		return

	actor_index += 1
	if is_enemys_turn and actor_index >= $Enemies.get_child_count():
		is_enemys_turn = false
		actor_index = 0
	elif not is_enemys_turn and actor_index >= $Heroes.get_child_count():
		is_enemys_turn = true
		actor_index = 0

	var current_actor: EncounterCharacter
	if is_enemys_turn:
		current_actor = $Enemies.get_child(actor_index)
	else:
		current_actor = $Heroes.get_child(actor_index)

	current_actor._on_turn()


func _on_actor_finished_acting(_actor: EncounterCharacter):
	next_character()


func is_encounter_over():
	var are_players_alive := len(get_tree().get_nodes_in_group("hero_alive")) > 0
	var are_enemies_alive := len(get_tree().get_nodes_in_group("enemy_alive")) > 0

	if are_enemies_alive and are_players_alive:
		return false # encounter isn't over!
	if are_enemies_alive:
		$HUD/Lose.show()
	else:
		$HUD/Win.show()
		get_tree().call_group("hero_alive", "victory_pose")
	return true # encounter is over
