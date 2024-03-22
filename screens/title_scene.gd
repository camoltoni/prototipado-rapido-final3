extends Node

func _on_Timer_timeout():
	assert(get_tree().change_scene("res://screens/instructions_scene.tscn") == OK)

