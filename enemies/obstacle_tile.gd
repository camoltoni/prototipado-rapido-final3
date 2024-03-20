class_name ObstacleTile
extends Area2D

signal enemy_hit

onready var animation_player:AnimationPlayer = $AnimationPlayer

func _ready():
	assert(connect(
		"enemy_hit", get_tree().current_scene, "_on_enemy_hit") == OK,
		"Signal not connected")

func _on_ObstacleTile_area_entered(_area):
	emit_signal("enemy_hit")
	animation_player.play("respawn", -1, rand_range(1.0, 2.0))
