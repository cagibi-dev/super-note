extends "res://characters/OverworldCharacter.gd"


var current_drag_event := -1
export (bool) var is_playable := true setget set_playable

onready var anim_node: AnimationPlayer = $Anim


func set_playable(new_playable: bool):
	is_playable = new_playable
	if not is_playable:
		current_drag_event = -1
		target_position = position
	if is_inside_tree():
		var bar_height := 0.0 if is_playable else 16.0
		create_tween().tween_property($CutsceneBars/Top, "margin_bottom", bar_height, 0.2)
		create_tween().tween_property($CutsceneBars/Bottom, "margin_top", -bar_height, 0.2)


func _ready():
	target_position = position


func handle_input():
	if anim_node.current_animation in ["percuss"] or not is_playable:
		return
	
	#if current_drag_event < 0:
	#	target_position = position + 10 * Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")

	"""if Input.is_action_just_pressed("use_instrument")
	and "WoodBlocks" in Globals.inventory:
		anim_node.play("percuss")
		if velocity.y == 0:
			velocity.x = 300 * $Sprite.scale.x
		else:
			velocity = 300 * input_vec
		input_vec = Vector2()"""


func percuss():
	var strike := preload("res://effects/Percussion.tscn").instance()
	strike.position = position + Vector2.UP * 8
	get_parent().add_child(strike)


func _process(_delta):
	if anim_node.current_animation in ["percuss"]:
		return

	if velocity.length() > max_speed / 2:
		anim_node.current_animation = "walk"
	else:
		anim_node.current_animation = "idle"
	update()


func _draw():
	draw_line(Vector2.UP * 10, target_position - position + Vector2.UP * 10, Color.black, 2)


func _on_ClickArea_input_event(_viewport, event: InputEvent, _shape_idx):
	# start moving if player is tapped
	if is_playable and event is InputEventScreenTouch and event.is_pressed() and current_drag_event < 0:
		$Tutorial.hide()
		current_drag_event = event.index


func _input(event: InputEvent):
	# keep moving when player is dragged
	if event is InputEventScreenDrag and event.index == current_drag_event:
		target_position = get_viewport().canvas_transform.inverse() * event.position - $ClickArea.position
	# stop tracking target position when player is untapped
	if event is InputEventScreenTouch and not event.is_pressed() and current_drag_event == event.index:
		current_drag_event = -1
