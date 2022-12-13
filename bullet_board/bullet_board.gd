extends Node2D

signal hurt
signal done


func _ready():
	spawn_bullets()


func spawn_bullets():
	var Bullet := preload("res://bullet_board/bullet.tscn")
	for i in [0, 1, 2, 3, 2, 1, 0, 1, 2, 3]:
		var bullet: RigidBody2D = Bullet.instantiate()
		bullet.position = Vector2(36 + 24 * i, 48)
		bullet.apply_central_impulse(Vector2(0, -64))
		add_child(bullet)
		bullet.z_index -= 1
		bullet.connect("destroyed", self._on_bullet_destroyed)
		await get_tree().create_timer(0.4).timeout
		bullet.z_index += 1
	await get_tree().create_timer(2.5).timeout
	$Rect/VibeLine.hide()
	create_tween().set_trans(Tween.TRANS_SINE).tween_property($Rect, "scale:x", 0, 0.2)
	emit_signal("done")
	#queue_free()


func _on_bullet_destroyed(pos: Vector2):
	var explosion := preload("res://bullet_board/bullet_explosion.tscn").instantiate()
	explosion.position = pos
	explosion.rotate(randf_range(-PI, PI))
	add_child(explosion)


func _on_vibe_line_body_entered(bullet: PhysicsBody2D):
	shake_screen()
	emit_signal("hurt")
	# the bullet is now out of range
	bullet.modulate = Color.RED
	bullet.input_pickable = false


func shake_screen():
	var tween := create_tween()
	for offset in [4, -4, 4, -4, 0]:
		tween.tween_property($Camera2D, "offset:x", offset, 0.05)
