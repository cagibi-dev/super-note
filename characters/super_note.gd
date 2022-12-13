extends "res://characters/character.gd"


@export var is_playable := true : set = set_playable
var uses_arrows := false


func set_playable(new_playable: bool):
	is_playable = new_playable
	if not is_playable:
		target_position = position
	if is_inside_tree():
		var bar_height := 0.0 if is_playable else 16.0
		create_tween().tween_property($CutsceneBars/Top, "offset_bottom", bar_height, 0.2)
		create_tween().tween_property($CutsceneBars/Bottom, "offset_top", -bar_height, 0.2)


func _process_input():
	if not is_playable:
		return
	# use arrow keys to move while there's no screen touch
	var arrow_vec := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if not arrow_vec.is_zero_approx():
		uses_arrows = true
	if uses_arrows:
		target_position = position + arrow_vec * 10


func _unhandled_input(event: InputEvent):
	if not is_playable:
		return
	if event is InputEventScreenTouch and event.is_pressed():
		uses_arrows = false
		target_position = get_viewport().canvas_transform.inverse() * event.position - Vector2.UP * 8
