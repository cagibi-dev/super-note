extends Node


var previous_room := ""
var previous_player_offset := Vector2()

# key = room filename,
# data = TODO
var room_data := {}

# our heroes
var party := [
	preload("res://characters/EncounterHero.tscn").instance(),
	preload("res://characters/EncounterHero.tscn").instance(),
	preload("res://characters/EncounterHero.tscn").instance(),
	preload("res://characters/EncounterHero.tscn").instance(),
	preload("res://characters/EncounterHero.tscn").instance(),
]
var inventory := ["CoolPotion", "DoesNothing", "CoolPotion"]

# stuff about encounters apart from our heroes
var encounter_data := {
	"enemies": [
		preload("res://enemies/Rat.tscn").instance(),
		preload("res://enemies/Rat.tscn").instance(),
		preload("res://enemies/Rat.tscn").instance(),
		preload("res://enemies/Rat.tscn").instance(),
		preload("res://enemies/Rat.tscn").instance(),
		preload("res://enemies/Rat.tscn").instance(),
		preload("res://enemies/Rat.tscn").instance(),
	],
	"scene": "sewers",
}


func _ready():
	OS.window_size *= 4


func goto_room(room_name: String):
	# by default: beginning
	if not room_name:
		room_name = "res://levels/sewers/Level-Sewers1.tscn"

	previous_room = get_tree().current_scene.filename
	get_tree().change_scene(room_name)

	# teleport player to where it came from + offset
	yield(get_tree(), "idle_frame")
	for transition in get_tree().get_nodes_in_group("transition"):
		if transition.destination == previous_room:
			var player: Node2D = get_tree().get_nodes_in_group("player")[0]
			player.global_position = transition.global_position - previous_player_offset * 1.5
			break
