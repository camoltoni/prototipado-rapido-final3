extends Area2D

signal ufo_hit

onready var animation_player:AnimationPlayer = $AnimationPlayer
onready var collision_laser:CollisionShape2D = $CollisionLaser
onready var collision_rescue:CollisionShape2D = $RescueArea/CollisionRescue
onready var audio_stream_player_2d:AudioStreamPlayer2D = $AudioStreamPlayer2D
onready var die_component = $DieComponent
onready var tween:Tween = $Tween
onready var sprite:Sprite = $Sprite
onready var rescue_stream:AudioStreamPlayer = $RescueStream

var inverse: = false

func _ready():
	sprite.modulate = Invader.INVADER_COLOR
	assert(animation_player.connect(
		"animation_finished", self, "_wait") == OK, 
		"Signal not connected")
	assert(connect(
		"ufo_hit", get_tree().current_scene, "_on_ufo_hit") == OK, 
		"Signal not connected")
	die_component.connect("died", self, "_died")

func _on_UFO_area_entered(_area):
	audio_stream_player_2d.stop()
	collision_laser.set_deferred("disabled", true)
	collision_rescue.set_deferred("disabled", true)
	die_component.start(sprite)

func _wait(anim_name):
	assert(get_tree().create_timer(
		rand_range(3.0, 6.0)).connect(
		"timeout", self, "_respawn", [anim_name]) == OK, 
		"Signal not connected")

func _respawn(anim_name):
	var new_anim: = ""
	scale = Vector2.ONE
	sprite.modulate = Invader.INVADER_COLOR
	collision_laser.disabled = false
	collision_rescue.disabled = false
	new_anim = "move_left" if anim_name == "move_right" else "move_right"
	position.y = rand_range(-16.0, 16.0)
	animation_player.play(new_anim)

func _died():
	emit_signal("ufo_hit")

func rescued():
	assert(tween.interpolate_property(
		self, 
		"scale", 
		scale, 
		Vector2.ZERO, 
		0.3, Tween.TRANS_CUBIC, 
		Tween.EASE_IN) == true)
	assert(tween.start() == true)
	audio_stream_player_2d.stop()
	rescue_stream.play()
