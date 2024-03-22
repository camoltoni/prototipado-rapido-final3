extends Node

onready var message_label:Label = $MessageLabel

func _ready():
	message_label.text = Global.message

func _process(delta):
	if Input.is_action_just_pressed("ui_select"):
		get_tree().change_scene("res://screens/title_scene.tscn")
