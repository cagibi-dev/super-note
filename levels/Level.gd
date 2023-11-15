extends Node2D


export (AudioStream) var music: AudioStream = null
const ROOM_SIZE := Vector2(256, 144)
const WALKOUT_OFFSET := 32
const TRANSITION_DURATION := 0.75

onready var player_node: Node2D = $Player
onready var cam_node: Camera2D = $Camera2D


func _enter_tree():
	Globals.play_music(music)


func _ready():
	$Frames.hide()
	cam_node.position = (player_node.position - ROOM_SIZE / 2)
	snap_camera()


func snap_camera():
	cam_node.position = cam_node.position.snapped(ROOM_SIZE)


func move_camera(cell_shift: Vector2):
	snap_camera()
	if player_node.is_playable:
		player_node.target_position += cell_shift * WALKOUT_OFFSET
	var tween := create_tween()
	tween.set_trans(Tween.TRANS_SINE)
	tween.tween_property(cam_node,
		"position",
		cam_node.position + ROOM_SIZE * cell_shift,
		TRANSITION_DURATION)


func _on_GoLeft_body_entered(_body):
	move_camera(Vector2(-1, 0))


func _on_GoRight_body_entered(_body):
	move_camera(Vector2(1, 0))


func _on_GoUp_body_entered(_body):
	move_camera(Vector2(0, -1))


func _on_GoDown_body_entered(_body):
	move_camera(Vector2(0, 1))
