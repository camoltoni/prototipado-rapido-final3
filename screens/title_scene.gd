extends Node

func _on_Timer_timeout():
	assert(get_tree().change_scene("res://screens/instructions_scene.tscn") == OK)

func _process(_delta):
	if Input.is_action_just_pressed("ui_select"):
		assert(get_tree().change_scene("res://screens/instructions_scene.tscn") == OK)
