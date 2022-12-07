extends Node2D


export (AudioStream) var music: AudioStream = null


func _enter_tree():
	Globals.play_music(music)

func _ready():
	$Frames.hide()
	$Camera2D.position = ($Player.position - Vector2(128, 72)).snapped(Vector2(256, 144))


func _on_GoLeft_body_entered(_body):
	create_tween() \
		.tween_property($Camera2D, "position:x", $Camera2D.position.x - 256, 0.5) \
		.set_trans(Tween.TRANS_SINE)


func _on_GoRight_body_entered(_body):
	create_tween() \
		.tween_property($Camera2D, "position:x", $Camera2D.position.x + 256, 0.5) \
		.set_trans(Tween.TRANS_SINE)


func _on_GoUp_body_entered(_body):
	create_tween() \
		.tween_property($Camera2D, "position:y", $Camera2D.position.y - 144, 0.5) \
		.set_trans(Tween.TRANS_SINE)


func _on_GoDown_body_entered(_body):
	create_tween() \
		.tween_property($Camera2D, "position:y", $Camera2D.position.y + 144, 0.5) \
		.set_trans(Tween.TRANS_SINE)
