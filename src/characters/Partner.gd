extends "res://characters/Character.gd"


@export (NodePath) var following: NodePath
var following_node: Node2D

func _ready():
	following_node = get_node(following)


func handle_input():
	if (position - following_node.position).length_squared() > 800:
		target_position = following_node.position
	else:
		target_position = position
