extends "res://props/Interactable.gd"


@export (bool) var active := true : set = set_active


func _ready():
	set_active(active)


func set_active(new_active: bool):
	active = new_active
	if not is_inside_tree():
		return
	if active:
		$Sprite2D.frame = 0
		$PointLight2D.show()
		$FlickerTimer.start()
	else:
		$Sprite2D.frame = 1
		$PointLight2D.hide()
		$FlickerTimer.stop()


# Those lamps can be shut checked/unchecked by smashing them
# body = percussion
func _on_body_entered(_body: PhysicsBody2D):
	set_active(not active)
	$Anim.play("hit")


func _on_FlickerTimer_timeout():
	# turn checked and unchecked
	if $PointLight2D.visible:
		$PointLight2D.hide()
		$FlickerTimer.wait_time = randf_range(0.05, 0.1)
	else:
		$PointLight2D.show()
		$FlickerTimer.wait_time = randf_range(0.2, 5)
	$FlickerTimer.start()
