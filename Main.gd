extends Node2D

var score:int = 0
var lifes:int = 40

func _on_enemy_hit():
	score += 1
	print_debug("score:", score)

func _on_invader_hit():
	lifes -= 1
	print_debug("lifes:", lifes)

func _on_ufo_hit():
	print_debug("ufo down")
