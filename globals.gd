extends Node


var previous_room := ""
var previous_player_offset := Vector2()

# our heroes
var party := [
	preload("res://characters/super_note.tscn").instantiate(),
]
var inventory := []
var money := 0 : set = set_money

# stuff about encounters apart from our heroes
var encounter_data := {
	"enemies": [
		#preload("res://enemies/Rat.tscn").instantiate(),
	],
	"scene": "sewers",
}

@onready var dialog_system: DialogSystem = $DialogSystem


func _ready():
	get_viewport().size *= 3


func set_money(new_money: int):
	money = new_money
	$Money.text = str(money)


func add_to_inventory(item: String):
	inventory.append(item)
	# here be special cases


func goto_room(room_name: String):
	previous_room = get_tree().current_scene.filename
	get_tree().change_scene_to_file(room_name)

	# teleport player to where it came from + offset
	await get_tree().idle_frame
	for transition in get_tree().get_nodes_in_group("transition"):
		if transition.destination == previous_room:
			# TODO: use more efficient stuff than groups
			#var player: Node2D = get_tree().get_nodes_in_group("player")[0]
			#player.global_position = transition.global_position - previous_player_offset * 1.5
			break


func play_music(music: AudioStream):
	var music_node: AudioStreamPlayer = $Music
	if music:
		if music_node.stream != music:
			music_node.stop()
			music_node.stream = music
			music_node.play()
	else:
		music_node.stop()
		music_node.stream = null


func _on_dialog_system_visibility_changed():
	pass # Replace with function body.
