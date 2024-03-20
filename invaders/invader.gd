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

const INVADER_COLOR = Color.ghostwhite
const INVADER_SELECTED_COLOR = Color.lawngreen
const ACCELERATION: = 40.0
const MARGIN: = Vector2(8.0, 8.0)

var unhandled = null

func _physics_process(_delta):
	global_position.x = clamp(global_position.x, view_rect.position.x, view_rect.end.x + MARGIN.x)
	global_position.y = clamp(global_position.y, view_rect.position.y, view_rect.end.y + MARGIN.y)

func fire():
	var laser:Laser = laser_scene.instance()
	laser.global_position = fire_position.global_position
	laser.collision_layer = laser_collision_layer
	laser.laser_speed = self.laser_speed
	get_tree().current_scene.add_child(laser)


func _on_Invader_area_entered(_area):
	emit_signal("invader_hit")
	if is_instance_valid(unhandled) and unhandled != null:
		unhandled.queue_free()
	queue_free()
	pass # Replace with function body.
