extends Node2D


@export var music: AudioStream = null
const ROOM_SIZE := Vector2(180, 240)
const WALKOUT_OFFSET := 32
const TRANSITION_DURATION := 0.75

@onready var cam_node: Camera2D = $Camera2D


func _enter_tree():
	$Frames.hide()
	Globals.play_music(music)
	for hero in Globals.party:
		add_child(hero)


func _exit_tree():
	for hero in Globals.party:
		remove_child(hero)


func dialog():
	for hero in Globals.party:
		hero.can_move = false
	var sn := "Super Note"
	Globals.dialog_system.start_dialog([
		DialogSystem.Line.new("With instruments, Super Note is able to communicate!"),
		DialogSystem.Line.new("Ah, wood blocks. I can talk now.", sn, DialogSystem.Face.SN_SMILE),
		DialogSystem.Line.new("They're a bit old though. I'd say they're...", sn, DialogSystem.Face.SN_SQUINT),
		DialogSystem.Line.new("200 years old!?", sn, DialogSystem.Face.SN_SHOCK),
		DialogSystem.Line.new("Is that really how long I was deactivated...?", sn, DialogSystem.Face.SN_WORRY),
	])
	await Globals.dialog_system.dialog_ended
	for hero in Globals.party:
		hero.can_move = true


func move_camera(relative: Vector2):
	cam_node.position += relative


func _on_go_left_body_entered(_body):
	move_camera(Vector2(-ROOM_SIZE.x, 0))


func _on_go_right_body_entered(_body):
	move_camera(Vector2(ROOM_SIZE.x, 0))


func _on_go_up_body_entered(_body):
	move_camera(Vector2(0, -ROOM_SIZE.y))


func _on_go_down_body_entered(_body):
	move_camera(Vector2(0, ROOM_SIZE.y))
