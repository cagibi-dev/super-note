extends Node2D
class_name EncounterCharacter

signal finished_acting
# warning-ignore:unused_signal
signal finished_reacting

export (String) var actor_name := "Generic actor"
export (int) var max_vibe := 12
export (int) var vibe := 12 setget set_vibe
export (int) var min_atk := 4
export (int) var atk_rand_range := 3

onready var vibe_bar_node: TextureProgress = $Vibe


func set_vibe(new_vibe: int):
	vibe = new_vibe
	if vibe_bar_node and is_inside_tree():
		vibe_bar_node.max_value = max_vibe
		create_tween().tween_property(vibe_bar_node, "value", float(vibe), 0.5)
	else:
		yield(self, "ready")
		vibe_bar_node.max_value = max_vibe
		vibe_bar_node.value = vibe


func is_alive() -> bool:
	return vibe > 0


func spawn_number(pos: Vector2, amount: int, is_heal := false):
	# spawn damage or heal number
	var damage := (\
		preload("res://encounter/Heal.tscn") \
		if is_heal else preload("res://encounter/Damage.tscn") \
		).instance()
	damage.rect_position += pos
	damage.text = str(amount)
	get_tree().current_scene.add_child(damage)


func _on_turn():
	# override this function!
	emit_signal("finished_acting")
