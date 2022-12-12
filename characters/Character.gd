extends CharacterBody2D
class_name Character


@export var character_name := "Generic character"
@export var target_position := position
@export var max_speed := 60.0

@onready var anim_node: AnimationPlayer = $Anim
@onready var sprite_node: Sprite2D = $Sprite2D


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
		await anim_node.animation_finished
		anim_node.play(new_anim)


func _process(_delta):
	handle_animation()


func _physics_process(_delta: float):
	handle_input()

	var input_vec := Vector2()
	if (target_position - position).length_squared() > 20.0:
		input_vec = (target_position - position).normalized()
	velocity = max_speed * input_vec

	if velocity.x > 0:
		sprite_node.scale.x = 1
	elif velocity.x < 0:
		sprite_node.scale.x = -1

	set_velocity(velocity)
	move_and_slide()
	velocity = velocity
