extends Node2D


export (AudioStream) var music: AudioStream = null
const ROOM_SIZE := Vector2(256, 144)
const WALKOUT_OFFSET := 32
const TRANSITION_DURATION := 0.75

onready var player_node: Node2D = $Player


func _enter_tree():
	Globals.play_music(music)

func _ready():
	#$Frames.hide()
	$Camera2D.position = (player_node.position - ROOM_SIZE / 2).snapped(ROOM_SIZE)


func snap_camera():
	$Camera2D.position = $Camera2D.position.snapped(ROOM_SIZE)


func _on_GoLeft_body_entered(_body):
	snap_camera()
	if player_node.is_playable:
		player_node.target_position.x -= WALKOUT_OFFSET
	$Camera2D/GoLeft.set_deferred("monitoring", false)
	var tween := create_tween()
	tween.set_trans(Tween.TRANS_SINE)
	tween.tween_property($Camera2D, "position:x", $Camera2D.position.x - ROOM_SIZE.x, TRANSITION_DURATION)
	tween.tween_property($Camera2D/GoLeft, "monitoring", true, 0)


func _on_GoRight_body_entered(_body):
	snap_camera()
	if player_node.is_playable:
		player_node.target_position.x += WALKOUT_OFFSET
	$Camera2D/GoRight.set_deferred("monitoring", false)
	var tween := create_tween()
	tween.set_trans(Tween.TRANS_SINE)
	tween.tween_property($Camera2D, "position:x", $Camera2D.position.x + ROOM_SIZE.x, TRANSITION_DURATION)
	tween.tween_property($Camera2D/GoRight, "monitoring", true, 0)


func _on_GoUp_body_entered(_body):
	snap_camera()
	if player_node.is_playable:
		player_node.target_position.y -= WALKOUT_OFFSET
	$Camera2D/GoUp.set_deferred("monitoring", false)
	var tween := create_tween()
	tween.set_trans(Tween.TRANS_SINE)
	tween.tween_property($Camera2D, "position:y", $Camera2D.position.y - ROOM_SIZE.y, TRANSITION_DURATION)
	tween.tween_property($Camera2D/GoUp, "monitoring", true, 0)


func _on_GoDown_body_entered(_body):
	snap_camera()
	if player_node.is_playable:
		player_node.target_position.y += WALKOUT_OFFSET
	$Camera2D/GoDown.set_deferred("monitoring", false)
	var tween := create_tween()
	tween.set_trans(Tween.TRANS_SINE)
	tween.tween_property($Camera2D, "position:y", $Camera2D.position.y + ROOM_SIZE.y, TRANSITION_DURATION)
	tween.tween_property($Camera2D/GoDown, "monitoring", true, 0)
