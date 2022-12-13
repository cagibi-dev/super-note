extends CharacterBody2D
class_name Character

# when the chara finished their turn in battle, emit this.
signal finished_acting

@export var character_name := "Generic character"
@export var target_position: Vector2
@export var max_speed := 60.0
@export var max_vibe := 12
@export var attack := 4

var vibe := max_vibe: set = set_vibe

@onready var anim_node: AnimationPlayer = $Anim
@onready var sprite_node: Sprite2D = $Sprite2D
@onready var vibe_bar_node: TextureProgressBar = $Vibe


func _ready():
	if target_position.is_zero_approx():
		target_position = position


func _process_input():
	pass # override this for AI or player input


func _process_animation():
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
	_process_animation()


func _physics_process(_delta: float):
	_process_input()

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


func set_vibe(new_vibe: int):
	vibe = new_vibe
	vibe_bar_node.visible = vibe > 0 and vibe < max_vibe
	if vibe_bar_node and is_inside_tree():
		vibe_bar_node.max_value = max_vibe
		create_tween().tween_property(vibe_bar_node, "value", float(vibe), 0.5)
