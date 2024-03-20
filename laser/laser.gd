class_name Laser
extends Area2D

export var laser_speed:float = 0.0

func _physics_process(delta):
	global_position = global_position.move_toward(
		global_position + Vector2(0, laser_speed), 
		delta * laser_speed * sign(laser_speed))

func _on_Laser_area_entered(_area):
	queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
