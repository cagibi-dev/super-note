extends "res://props/Interactable.gd"


export (bool) var active := true

func _ready():
	if not active:
		$Sprite.frame = 1
		$Light2D.hide()
		$FlickerTimer.stop()

# TODO: Those lamps can be shut off by smashing them


func _on_FlickerTimer_timeout():
	# turn on and off
	if $Light2D.visible:
		$Light2D.hide()
		$FlickerTimer.wait_time = rand_range(0.05, 0.1)
	else:
		$Light2D.show()
		$FlickerTimer.wait_time = rand_range(0.2, 5)
	$FlickerTimer.start()
