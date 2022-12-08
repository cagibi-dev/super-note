extends PanelContainer

signal dialog_ended

# Each line is a Dict with keys: name?, message, portrait?
# all of them String values
export (Array) var lines := []
export (int) var character_step := 2

onready var msg_node: Label = $HBoxContainer/Message


func start_dialog(new_lines: Array):
	show()
	lines = new_lines
	start_line()


func portrait(face_name: String) -> Vector2:
	match face_name:
		"sn_smile": return Vector2(0, 0)
		"sn_squint": return Vector2(1, 0)
		"sn_shock": return Vector2(2, 0)
		"sn_worry": return Vector2(3, 0)
	return Vector2(0, 0)


func start_line():
	var new_line: Dictionary = lines[0]
	msg_node.text = new_line["message"]
	if new_line.has("name"):
		$Node2D/Name.text = new_line["name"]
	else:
		$Node2D/Name.text = ""
	if new_line.has("portrait"):
		$HBoxContainer/Portrait.show()
		$HBoxContainer/Portrait.texture.region.position.x = 2 + 32 * portrait(new_line["portrait"]).x
		$HBoxContainer/Portrait.texture.region.position.y = 2 + 32 * portrait(new_line["portrait"]).y
	else:
		$HBoxContainer/Portrait.hide()
	msg_node.percent_visible = 0
	$Line2D.hide()
	$CharTimer.start()


func _on_Next_pressed():
	if msg_node.percent_visible < 1:
		# just skip text
		msg_node.percent_visible = 1
		$Line2D.show()
		$CharTimer.stop()
		return

	# next line
	lines.pop_front()
	if len(lines) == 0:
		hide()
		# TODO play finish sound
		emit_signal("dialog_ended")
	else:
		$NextLine.play()
		start_line()


func _on_CharTimer_timeout():
	msg_node.visible_characters += character_step
	$Talk.play()
	if msg_node.percent_visible >= 1:
		$Line2D.show()
		$CharTimer.stop()


func _on_DialogBox_visibility_changed():
	if visible:
		$HBoxContainer/Next.grab_focus()
