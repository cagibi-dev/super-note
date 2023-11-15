extends "res://characters/Character.gd"


export (bool) var is_playable := true setget set_playable


func set_playable(new_playable: bool):
	is_playable = new_playable
	if not is_playable:
		target_position = position
	if is_inside_tree():
		var bar_height := 0.0 if is_playable else 16.0
		create_tween().tween_property($CutsceneBars/Top, "margin_bottom", bar_height, 0.2)
		create_tween().tween_property($CutsceneBars/Bottom, "margin_top", -bar_height, 0.2)


func _ready():
	target_position = position


func handle_input():
	if not is_playable:
		return
	# TODO arrow keys on PC only


func handle_animation():
	if anim_node.current_animation in ["percuss"]:
		return

	.handle_animation()
	update()


func _unhandled_input(event: InputEvent):
	if not is_playable:
		return
	if event is InputEventScreenTouch and event.is_pressed():
		$Tutorial.hide()
		target_position = get_viewport().canvas_transform.inverse() * event.position - Vector2.UP * 8
