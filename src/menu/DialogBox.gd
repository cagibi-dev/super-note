extends PanelContainer

signal dialog_ended

export (Array) var lines := []

onready var msg_node: Label = $HBoxContainer/Message


func start_dialog(new_lines: Array):
	show()
	lines = new_lines
	start_line()


func start_line():
	msg_node.text = lines[0]
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
		emit_signal("dialog_ended")
	else:
		start_line()


func _on_CharTimer_timeout():
	msg_node.visible_characters += 2
	if msg_node.percent_visible >= 1:
		$Line2D.show()
	else:
		$CharTimer.start()


func _on_DialogBox_visibility_changed():
	if visible:
		$HBoxContainer/Next.grab_focus()
