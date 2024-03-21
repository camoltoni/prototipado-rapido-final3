class_name UnhandledInvader
extends Invader

onready var fire_timer:Timer = $FireTimer

signal handling

export var dancing_frames: = [0,1]

onready var frames:SpriteFrames = animated_sprite.frames

# Called when the node enters the scene tree for the first time.
func _ready():
	animated_sprite.modulate = INVADER_COLOR
	frames.add_animation(name)
	frames.set_animation_speed(name, 4.0)
	for n in dancing_frames:
		frames.add_frame(name, frames.get_frame("default", n))
	animated_sprite.play(name)
	animated_sprite.modulate = INVADER_COLOR
	fire_timer.start(rand_range(0.5, 2.5))
	assert(connect(
		"invader_hit", owner, "_on_invader_hit")==OK,
		"Signal not connected")
	assert(connect(
		"handling", owner, "_handling_invader")==OK, 
		"Signal not connected")

func _on_UnhandledInvader_input_event(_viewport, event, _shape_idx):
	if (event is InputEventMouseButton && event.pressed):
		laser_collision_shape.disabled = true
		visible = false
		emit_signal("handling", self)

func _on_FireTimer_timeout():
	if randf() < 0.15:
		fire()
	fire_timer.start(rand_range(1.0, 3.0))
