extends RigidBody2D

signal destroyed(position)


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_input_event(_viewport, event: InputEvent, _shape_idx):
	if event is InputEventScreenTouch and event.is_pressed():
		emit_signal("destroyed", position)
		queue_free()
