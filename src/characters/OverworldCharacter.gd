extends KinematicBody2D


var velocity := Vector2()
export (Vector2) var input_vec := Vector2()
export (float) var max_speed := 72.0


func handle_input():
	pass # override this!


func _physics_process(delta: float):
	handle_input()

	velocity = lerp(velocity, max_speed * input_vec, 12 * delta)

	if input_vec.x > 0:
		$Sprite.scale.x = 1
	elif input_vec.x < 0:
		$Sprite.scale.x = -1

	velocity = move_and_slide(velocity)
