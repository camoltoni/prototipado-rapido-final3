extends Control

onready var label_rescued:Label = $CanvasLayer/HBoxContainer/LabelRescued
onready var label_score:Label = $CanvasLayer/HBoxContainer/LabelScore
onready var label_lifes:Label = $CanvasLayer/HBoxContainer/LabelLifes


func update_rescued(value:int):
	label_rescued.text = "TO BE RESCUED: "+ str(value)

func update_score(value:int):
	label_score.text = "SCORE: " + "%08d" % value

func update_lifes(value:int):
	label_lifes.text = "LIFES: " + ("%02d" % value)
