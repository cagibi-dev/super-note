extends PanelContainer
class_name DialogSystem

signal dialog_ended

# Each line is a Dict with keys: name?, text, portrait?
# all of them String values
export (Array) var lines := []
export (int) var character_step := 2

onready var msg_node: Label = $HBoxContainer/Message
onready var name_node: Label = $Node2D/Name
onready var portrait_node: TextureRect = $HBoxContainer/Portrait
onready var talk_sound: AudioStreamPlayer = $Bleeps/SN


func portrait(face_name: String) -> Vector2:
	# converts portrait string to cell vector.
	match face_name:
		"sn_smile": return Vector2(0, 0)
		"sn_squint": return Vector2(1, 0)
		"sn_shock": return Vector2(2, 0)
		"sn_worry": return Vector2(3, 0)
		"sn_sad": return Vector2(4, 0)
		"sn_grin": return Vector2(5, 0)
		"sn_think": return Vector2(6, 0)
		"an_neutral": return Vector2(0, 1)
		"an_smile": return Vector2(1, 1)
		"an_panic": return Vector2(2, 1)
		"an_think": return Vector2(3, 1)
		"an_sad": return Vector2(4, 1)
		"an_angry": return Vector2(5, 1)
	return Vector2(0, 0)


func start_dialog(new_lines: Array):
	show()
	lines = new_lines
	start_line()


func start_line():
	var new_line: Dictionary = lines[0]
	msg_node.text = new_line["text"]

	# add line to backlog
	$Node2D/History/Lines/Text.text += "\n" + new_line["text"]

	if new_line.has("name"):
		name_node.text = new_line["name"]
		if new_line["name"] == "Super Note":
			talk_sound = $Bleeps/SN
		elif new_line["name"] == "Armonica":
			talk_sound = $Bleeps/AN
		else:
			talk_sound = $Bleeps/FlavorText
	else:
		name_node.text = ""
		talk_sound = $Bleeps/FlavorText

	if new_line.has("portrait"):
		var cell := portrait(new_line["portrait"])
		portrait_node.show()
		portrait_node.texture.region.position.x = 2 + 32 * cell.x
		portrait_node.texture.region.position.y = 2 + 32 * cell.y
	else:
		portrait_node.hide()
	msg_node.percent_visible = 0
	$ArrowNext.hide()
	$CharTimer.start()


func _on_next_pressed():
	if msg_node.percent_visible < 1:
		# just skip text
		msg_node.percent_visible = 1
		$ArrowNext.show()
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
	talk_sound.play()
	if msg_node.percent_visible >= 1:
		$ArrowNext.show()
		$CharTimer.stop()


func _on_DialogBox_visibility_changed():
	$Next/Touch.visible = visible
	if visible:
		$Next/Touch.grab_focus()


func _on_Backlog_pressed():
	if $Node2D/History.visible:
		$Node2D/History/Close.play()
		$Next/Touch.show()
		$Node2D/History.hide()
		create_tween().tween_property(self, "rect_position", Vector2(4, 6), 0.5)
	else:
		$Node2D/History/Open.play()
		$Next/Touch.hide()
		$Node2D/History.show()
		create_tween().tween_property(self, "rect_position", Vector2(4, 120), 0.5)
