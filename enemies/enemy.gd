extends Area2D

signal enemy_hit

const COLOR_ENEMY = Color.magenta
export var laser_scene:PackedScene
export var laser_collision_layer:int = 0
export var laser_speed:float = -40.0

onready var fire_position:Position2D = $FirePosition
onready var animation_player:AnimationPlayer = $AnimationPlayer
onready var animation_timer:Timer = $AnimationTimer
onready var collision_polygon_2d = $CollisionPolygon2D

var direction:= 1

func _ready():
	modulate = COLOR_ENEMY
	assert(connect(
		"enemy_hit", get_tree().current_scene, "_on_enemy_hit") == OK,
		"Signal not connected")
	animation_player.play("spawn")

func fire():
	var laser:Laser = laser_scene.instance()
	laser.global_position = fire_position.global_position
	laser.collision_layer = laser_collision_layer
	laser.laser_speed = laser_speed
	laser.modulate = COLOR_ENEMY
	get_tree().current_scene.add_child(laser)

func _process(_delta):
	position = position * Vector2(direction, 1)

func _move():
	animation_player.play("move", -1, rand_range(0.5, 1.15))
	if randf() < 0.5:
		direction = -1

func _on_AnimationTimer_timeout():
	animation_player.playback_speed = rand_range(0.5, 1.15)
	animation_timer.start(rand_range(2.5, 5.0))
	
func _on_Area2D_area_entered(_area):
	emit_signal("enemy_hit")
	animation_player.play("respawn", -1, rand_range(1.0, 2.0))



