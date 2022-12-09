extends Node2D


export (AudioStream) var music: AudioStream = null

onready var player_node: Node2D = $Player


func _enter_tree():
	Globals.play_music(music)

func _ready():
	$Frames.hide()
	$Camera2D.position = (player_node.position - Vector2(128, 72)).snapped(Vector2(256, 144))


func _on_GoLeft_body_entered(_body):
	if player_node.is_playable:
		player_node.target_position.x -= 24
	$Camera2D/GoLeft.set_deferred("monitoring", false)
	var tween := create_tween()
	tween.set_trans(Tween.TRANS_SINE)
	tween.tween_property($Camera2D, "position:x", $Camera2D.position.x - 256, 0.5)
	tween.tween_property($Camera2D/GoLeft, "monitoring", true, 0)


func _on_GoRight_body_entered(_body):
	if player_node.is_playable:
		player_node.target_position.x += 24
	$Camera2D/GoRight.set_deferred("monitoring", false)
	var tween := create_tween()
	tween.set_trans(Tween.TRANS_SINE)
	tween.tween_property($Camera2D, "position:x", $Camera2D.position.x + 256, 0.5)
	tween.tween_property($Camera2D/GoRight, "monitoring", true, 0)


func _on_GoUp_body_entered(_body):
	if player_node.is_playable:
		player_node.target_position.y -= 24
	$Camera2D/GoUp.set_deferred("monitoring", false)
	var tween := create_tween()
	tween.set_trans(Tween.TRANS_SINE)
	tween.tween_property($Camera2D, "position:y", $Camera2D.position.y - 144, 0.5)
	tween.tween_property($Camera2D/GoUp, "monitoring", true, 0)


func _on_GoDown_body_entered(_body):
	if player_node.is_playable:
		player_node.target_position.y += 24
	$Camera2D/GoDown.set_deferred("monitoring", false)
	var tween := create_tween()
	tween.set_trans(Tween.TRANS_SINE)
	tween.tween_property($Camera2D, "position:y", $Camera2D.position.y + 144, 0.5)
	tween.tween_property($Camera2D/GoDown, "monitoring", true, 0)
