extends KinematicBody2D


var velocity := Vector2()
var input_vec := Vector2()


func handle_input():
	pass # override this!


func _physics_process(delta: float):
	handle_input()

	velocity = lerp(velocity, 64 * input_vec, 10 * delta)

	if input_vec.x > 0:
		$Sprite.scale.x = 1
	elif input_vec.x < 0:
		$Sprite.scale.x = -1

	velocity = move_and_slide(velocity)
