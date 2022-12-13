extends Area2D


@export_file("*.tscn") var destination: String


func _on_body_entered(body: Node2D):
	var offset := body.global_position - global_position
	# orthogonalize
	if abs(offset.y) > abs(offset.x):
		offset.x = 0
	else:
		offset.y = 0

	Globals.previous_player_offset = offset
	Globals.goto_room(destination)
