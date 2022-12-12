extends Node2D


@export var music: AudioStream = null
const ROOM_SIZE := Vector2(256, 144)
const WALKOUT_OFFSET := 32
const TRANSITION_DURATION := 0.75

@onready var player_node: Node2D = $Player
@onready var cam_node: Camera2D = $Camera2D


func _enter_tree():
	Globals.play_music(music)
