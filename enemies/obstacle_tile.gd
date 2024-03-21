class_name ObstacleTile
extends Area2D

signal enemy_hit(score)

onready var animation_player:AnimationPlayer = $AnimationPlayer
onready var sprite:Sprite = $Sprite
onready var die_component:DieComponent = $DieComponent

func _ready():
	sprite.modulate = Color.gold
	assert(connect(
		"enemy_hit", get_tree().current_scene, "_on_enemy_hit") == OK,
		"Signal not connected")
	assert(die_component.connect(
		"died", self, "_died") == OK, 
		"Signal not connected")

func _on_ObstacleTile_area_entered(_area):
	emit_signal("enemy_hit", 5)
	die_component.start(sprite)

func _died():
	animation_player.play("respawn", -1, rand_range(1.0, 2.0))
