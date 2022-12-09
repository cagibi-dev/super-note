extends "res://props/Interactable.gd"


func _on_body_entered(_body: PhysicsBody2D):
	queue_free()
