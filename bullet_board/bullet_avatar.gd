extends RigidBody2D

signal hurt(bullet)

var is_pulled := false
var target_x := 0.0


func _physics_process(_delta: float):
	if is_pulled:
		apply_central_force(Vector2(
			target_x - global_position.x, 0
			).normalized() * 500)


func _unhandled_input(event: InputEvent):
	if event is InputEventScreenTouch:
		if event.is_pressed():
			is_pulled = true
			target_x = event.position.x
		else:
			is_pulled = false
	elif event is InputEventScreenDrag:
		if is_pulled:
			target_x = event.position.x


func _on_hitbox_body_entered(body: PhysicsBody2D):
	emit_signal("hurt", body)
