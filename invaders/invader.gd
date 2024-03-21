class_name Invader
extends Area2D

signal invader_hit

export var speed := 200.0
export var laser_speed: = 100
export var laser_scene:PackedScene
export var laser_collision_layer:int = 4

onready var initial_position = position
onready var view_rect = get_viewport_rect()
onready var fire_position = $FirePosition
onready var die_component:DieComponent = $DieComponent
onready var animated_sprite:AnimatedSprite = $AnimatedSprite
onready var laser_collision_shape:CollisionShape2D = $LaserCollisionShape
onready var audio_stream_player:AudioStreamPlayer = $AudioStreamPlayer

const INVADER_COLOR = Color.ghostwhite
const INVADER_SELECTED_COLOR = Color.lawngreen
const ACCELERATION: = 40.0
const MARGIN: = Vector2(8.0, 8.0)

var unhandled = null

func _ready():
	assert(die_component.connect(
		"died", self, "_on_died") == OK, 
		"Signal not connected")

func _physics_process(_delta):
	global_position.x = clamp(global_position.x, view_rect.position.x, view_rect.end.x + MARGIN.x)
	global_position.y = clamp(global_position.y, view_rect.position.y, view_rect.end.y + MARGIN.y)

func fire():
	var laser:Laser = laser_scene.instance()
	laser.global_position = fire_position.global_position
	laser.collision_layer = laser_collision_layer
	laser.laser_speed = self.laser_speed
	get_tree().current_scene.add_child(laser)
	audio_stream_player.play()
	

func _on_Invader_area_entered(_area):
	emit_signal("invader_hit")
	laser_collision_shape.set_deferred("disabled", true)
	die_component.start(animated_sprite)

func _on_died():
	if is_instance_valid(unhandled) and unhandled != null:
		unhandled.queue_free()
	queue_free()

