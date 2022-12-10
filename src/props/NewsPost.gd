extends "res://props/Interactable.gd"


export (Array, Dictionary) var lines := []



func _on_1_pressed():
	Globals.dialog_system.start_dialog(lines)
