extends PanelContainer
class_name DialogSystem

signal dialog_ended

enum Face {
	NONE, SN_SMILE, SN_SQUINT, SN_SHOCK, SN_WORRY, SN_SAD, SN_GRIN, SN_THINK,
	AN_NEUTRAL, AN_SMILE, AN_FEAR, AN_HUH, AN_SAD, AN_ANGRY, U1, U2,
	EK_NEUTRAL, EK_SMILE,
}

# Each line is a Dict with keys: name?, text, portrait?
# all of them String values
@export var lines: Array = []
@export var character_step := 2

@onready var msg_node: Label = $Rows/HBoxContainer/Message
@onready var name_node: Label = $OutOfBox/BoxHeader/Name
@onready var portrait_node: TextureRect = $Rows/HBoxContainer/Portrait
@onready var talk_sound: AudioStreamPlayer = $Bleeps/SN
@onready var arrow_node: CanvasItem = $OutOfBox/BoxHeader/ArrowNext


class Line:
	var name := ""
	var face := Face.NONE
	var text := ""

	func _init(_text: String, _name := "", _face := Face.NONE):
		text = _text
		name = _name
		face = _face


func start_dialog(new_lines: Array):
	show()
	lines = new_lines
	start_line()


func start_line():
	var new_line: Line = lines[0]
	msg_node.text = new_line.text

	# add line to backlog
	$OutOfBox/History/Lines/Text.text += "\n" + new_line.text

	name_node.text = new_line.name
	talk_sound = $Bleeps/FlavorText
	match new_line.name:
		"Super Note": talk_sound = $Bleeps/SN
		"Armonica": talk_sound = $Bleeps/AN

	if new_line.face != Face.NONE:
		@warning_ignore(integer_division)
		var cell := Vector2i(new_line.face % 8, new_line.face / 8)
		portrait_node.show()
		portrait_node.texture.region.position.x = 28 * cell.x
		portrait_node.texture.region.position.y = 28 * cell.y
	else:
		portrait_node.hide()
	msg_node.visible_characters = 0
	arrow_node.hide()
	$CharTimer.start()


func _on_next_pressed():
	if msg_node.visible_ratio < 1:
		# just skip text
		msg_node.visible_ratio = 1
		arrow_node.show()
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
	if msg_node.visible_ratio >= 1:
		arrow_node.show()
		$CharTimer.stop()


func _on_DialogBox_visibility_changed():
	$Next/Touch.visible = visible
	if visible:
		$Next/Touch.grab_focus()


func _on_Backlog_pressed():
	if $OutOfBox/History.visible:
		$OutOfBox/History/Close.play()
		$Next/Touch.show()
		$OutOfBox/History.hide()
		create_tween().tween_property(self, "position", Vector2(4, 6), 0.5)
	else:
		$OutOfBox/History/Open.play()
		$Next/Touch.hide()
		$OutOfBox/History.show()
		create_tween().tween_property(self, "position", Vector2(4, 120), 0.5)
