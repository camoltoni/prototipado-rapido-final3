extends Node2D

onready var hud = $HUD

var score:int = 0
var lifes:int = 40
var rescued:int = 5

func _ready():
	hud.update_lifes(lifes)
	hud.update_rescued(rescued)
	hud.update_score(score)

func _on_enemy_hit(value):
	score += value
	hud.update_score(score)

func _on_invader_hit():
	lifes -= 1
	hud.update_lifes(lifes)
	if lifes <= 0:
		Global.message = "YOU LOSE"
		assert(get_tree().change_scene("res://screens/end_screen.tscn") == OK)

func _on_ufo_hit():
	score -= 100
	hud.update_score(score)

func _on_ufo_rescued():
	score += 1000
	rescued -= 1
	hud.update_score(score)
	hud.update_rescued(rescued)
	if rescued <= 0:
		Global.final_score = score
		Global.message = "YOU WIN!\n" + "%d" % Global.final_score
		assert(get_tree().change_scene("res://screens/end_screen.tscn") == OK)
