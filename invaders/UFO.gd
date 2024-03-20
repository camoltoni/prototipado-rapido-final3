extends Area2D

signal ufo_hit

onready var animation_player:AnimationPlayer = $AnimationPlayer
onready var collision_shape_2d:CollisionShape2D = $CollisionShape2D
onready var audio_stream_player_2d:AudioStreamPlayer2D = $AudioStreamPlayer2D
onready var die_component = $DieComponent

var inverse: = false

func _ready():
	animation_player.connect("animation_finished", self, "_wait")
	connect("ufo_hit", get_tree().current_scene, "_on_ufo_hit")
	die_component.connect("died", self, "_died")

func _on_UFO_area_entered(_area):
	audio_stream_player_2d.stop()
	collision_shape_2d.set_deferred("disabled", true)
	die_component.start()

func _wait(anim_name):
	get_tree().create_timer(
		rand_range(3.0, 6.0)).connect(
		"timeout", self, "_respawn", [anim_name])

func _respawn(anim_name):
	var new_anim: = ""
	modulate = Invader.INVADER_COLOR
	collision_shape_2d.disabled = false
	new_anim = "move_left" if anim_name == "move_right" else "move_right"
	position.y = rand_range(-16.0, 16.0)
	animation_player.play(new_anim)

func _died():
	emit_signal("ufo_hit")
