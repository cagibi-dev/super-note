extends Area2D


var interactor: Node2D = null

onready var menu_container_node := $MenuTail
onready var actions_node := $MenuTail/Menu/Actions


func _on_body_entered(body: PhysicsBody2D):
	interactor = body
	menu_container_node.show()
	actions_node.get_child(0).grab_focus()


func _on_body_exited(_body):
	interactor = null
	menu_container_node.hide()
