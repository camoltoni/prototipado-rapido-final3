extends Node2D

signal invader_hit

export var handled_invader_scene:PackedScene

onready var invaders = $Invaders

var handled = null

func _ready():
	assert(connect(
		"invader_hit", get_tree().current_scene, "_on_invader_hit") == OK,
		"Signal not connected")

func _handling_invader(unhandled_invader:UnhandledInvader):
	if is_instance_valid(handled) and handled != null:
		(handled as HandledInvader).animated_sprite.modulate = Invader.INVADER_COLOR
		handled.returning = true
	var handled_invader:HandledInvader = handled_invader_scene.instance()
	get_owner().add_child(handled_invader)
	handled_invader.global_position = unhandled_invader.global_position
	handled_invader.unhandled = unhandled_invader
	var anim_name = "i"+str(handled_invader.get_instance_id())
	handled_invader.frames.add_animation(anim_name)
	handled_invader.frames.set_animation_speed(anim_name, 4.0)
	for n in unhandled_invader.dancing_frames:
		handled_invader.frames.add_frame(anim_name, handled_invader.frames.get_frame("default", n))
	handled_invader.animated_sprite.play(anim_name)
	handled_invader.animated_sprite.modulate = Invader.INVADER_SELECTED_COLOR
	handled = handled_invader
	#handled_invader.connect("invader_hit", owner, "_on_invader_hit")

func _on_invader_hit():
	emit_signal("invader_hit")
