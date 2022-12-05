extends "res://characters/OverworldCharacter.gd"


onready var anim_node: AnimationPlayer = $Anim


func handle_input():
	input_vec.x = Input.get_axis("ui_left", "ui_right")
	input_vec.y = Input.get_axis("ui_up", "ui_down")
	if input_vec.length_squared() > 1.0:
		input_vec = input_vec.normalized()


func _process(_delta):
	if input_vec.length_squared() > 0:
		anim_node.current_animation = "walk"
	else:
		anim_node.current_animation = "idle"
