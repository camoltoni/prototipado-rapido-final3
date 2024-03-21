extends Node2D

signal invader_hit

const SCROLL_SPEED: = 10.0
export var handled_invader_scene:PackedScene

onready var invaders = $Invaders
onready var sky_layer:ParallaxLayer = $ParallaxBackground/SkyLayer
onready var city_layer:ParallaxLayer = $ParallaxBackground/CityLayer


var handled = null

func _ready():
	assert(connect(
		"invader_hit", get_tree().current_scene, "_on_invader_hit") == OK,
		"Signal not connected")

func _process(delta):
	if is_instance_valid(handled) and handled != null:
		sky_layer.motion_offset.x += -SCROLL_SPEED * (handled as HandledInvader).direction.x * delta
		city_layer.motion_offset.x += -SCROLL_SPEED * 3 * (handled as HandledInvader).direction.x * delta
		pass

func _handling_invader(unhandled_invader:UnhandledInvader):
	if is_instance_valid(handled) and handled != null:
		(handled as HandledInvader).animated_sprite.modulate = Invader.INVADER_COLOR
		(handled as HandledInvader).rescue_collision_poly.disabled = true
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
	handled = handled_invader

func _on_invader_hit():
	emit_signal("invader_hit")
