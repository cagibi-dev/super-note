extends Area2D


func _on_body_entered(_body):
	$OpenMenu.show()
	$OpenMenu/Open.grab_focus()


func _on_body_exited(_body):
	$OpenMenu.hide()


func _on_Open_pressed():
	$OpenMenu.hide()
	$Sprite.frame = 1 - $Sprite.frame
	$OpenMenu/Open.text = "Close" if $OpenMenu/Open.text == "Open" else "Open"
