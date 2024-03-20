extends Node2D

signal died

export var particle_texture:StreamTexture
export var sound:AudioStream

onready var particles_2d:Particles2D = $Particles2D
onready var tween:Tween = $Tween
onready var audio_stream_player_2d:AudioStreamPlayer2D = $AudioStreamPlayer2D

func _ready():
	particles_2d.texture = particle_texture
	audio_stream_player_2d.stream = sound
	assert(tween.connect(
		"tween_completed", self, "_died") == OK,
		"Signal not connected")

func start():
	create_tween()
	particles_2d.emitting = true
	tween.start()
	audio_stream_player_2d.play()


func _died(_object, _key):
	emit_signal("died")

func create_tween():
	assert(tween.interpolate_property(
		owner, 
		"modulate", 
		owner.modulate, 
		Color("#0fff"), 
		0.2, 
		Tween.TRANS_CUBIC,Tween.EASE_IN)==true)
