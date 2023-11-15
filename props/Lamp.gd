extends "res://props/Interactable.gd"


export (bool) var active := true setget set_active


func _ready():
	set_active(active)


func set_active(new_active: bool):
	active = new_active
	if not is_inside_tree():
		return
	if active:
		$Sprite.frame = 0
		$Light2D.show()
		$FlickerTimer.start()
	else:
		$Sprite.frame = 1
		$Light2D.hide()
		$FlickerTimer.stop()


# Those lamps can be shut on/off by smashing them
# body = percussion
func _on_body_entered(_body: PhysicsBody2D):
	set_active(not active)
	$Anim.play("hit")


func _on_FlickerTimer_timeout():
	# turn on and off
	if $Light2D.visible:
		$Light2D.hide()
		$FlickerTimer.wait_time = rand_range(0.05, 0.1)
	else:
		$Light2D.show()
		$FlickerTimer.wait_time = rand_range(0.2, 5)
	$FlickerTimer.start()
