extends KinematicBody2D


var velocity := Vector2()
export (Vector2) var target_position := position
export (float) var max_speed := 72.0
export (float) var acceleration := 10.0

onready var sprite_node: Sprite = $Sprite


func handle_input():
	pass # override this for AI or player input!


func _physics_process(delta: float):
	handle_input()

	var input_vec := Vector2()
	if (target_position - position).length_squared() > 20.0:
		input_vec = (target_position - position).normalized()
	velocity = lerp(velocity, max_speed * input_vec, acceleration * delta)

	if velocity.x > 0:
		sprite_node.scale.x = 1
	elif velocity.x < 0:
		sprite_node.scale.x = -1

	velocity = move_and_slide(velocity)
