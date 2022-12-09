extends KinematicBody2D


var velocity := Vector2()
export (String) var actor_name := "Generic actor"
export (Vector2) var target_position := position
export (float) var max_speed := 72.0
export (float) var acceleration := 10.0

onready var anim_node: AnimationPlayer = $Anim
onready var sprite_node: Sprite = $Sprite


func handle_input():
	pass # override this for AI or player input


func handle_animation():
	var new_anim := anim_node.current_animation
	if velocity.length() > max_speed / 5:
		new_anim = "walk"
	else:
		new_anim = "idle"
	if anim_node.current_animation != new_anim:
		anim_node.play("RESET")
		yield(anim_node, "animation_finished")
		anim_node.play(new_anim)


func _process(_delta):
	handle_animation()


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
