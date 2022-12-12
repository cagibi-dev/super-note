extends Node2D


@export var music: AudioStream = null
const ROOM_SIZE := Vector2(180, 240)
const WALKOUT_OFFSET := 32
const TRANSITION_DURATION := 0.75

@onready var player_node: Node2D = $Player
@onready var cam_node: Camera2D = $Camera2D


func _enter_tree():
	Globals.play_music(music)


func _ready():
	player_node.is_playable = false
	var sn := "Super Note"
	Globals.dialog_system.start_dialog([
		DialogSystem.Line.new("With instruments, Super Note is able to communicate!"),
		DialogSystem.Line.new("Ah, wood blocks. I can talk now.", sn, DialogSystem.Face.SN_SMILE),
		DialogSystem.Line.new("They're a bit old though. I'd say they're...", sn, DialogSystem.Face.SN_SQUINT),
		DialogSystem.Line.new("200 years old!?", sn, DialogSystem.Face.SN_SHOCK),
		DialogSystem.Line.new("Is that really how long I was deactivated...?", sn, DialogSystem.Face.SN_WORRY),
	])
	await Globals.dialog_system.dialog_ended
	player_node.is_playable = true
