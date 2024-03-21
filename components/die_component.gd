class_name DieComponent
extends Node2D

signal died

onready var particles_2d:Particles2D = $Particles2D
onready var tween:Tween = $Tween
onready var audio_stream_player:AudioStreamPlayer = $AudioStreamPlayer

func _ready():
	assert(audio_stream_player.connect("finished", self, "_died") == OK,
		"Signal not connected")

func start(sprite):
	particles_2d.emitting = true
	audio_stream_player.play()
	make_tween(sprite)
	assert(tween.start() == true, "Tween not started")

func _died():
	emit_signal("died")

func make_tween(sprite):
	particles_2d.modulate = sprite.modulate
	assert(tween.interpolate_property(
		sprite, 
		"modulate:a", 
		1.0, 
		0.0, 
		0.2, 
		Tween.TRANS_CUBIC,Tween.EASE_IN) == true, "Tween not started")
