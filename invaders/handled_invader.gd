class_name HandledInvader
extends Invader

signal ufo_rescued

onready var frames:SpriteFrames = animated_sprite.frames
onready var fire_timer:Timer = $FireTimer
onready var animation_player:AnimationPlayer = $AnimationPlayer
onready var rescue_collision_poly:CollisionPolygon2D = $RescueArea/RescueCollisionPoly

var returning: = false
var direction: = Vector2()

var can_fire: = true
var can_rescue:= true

func _ready():
	assert(connect(
		"invader_hit", get_tree().current_scene, "_on_invader_hit") == OK,
		"Signal not connected")
	assert(connect(
		"ufo_rescued", get_tree().current_scene, "_on_ufo_rescued") == OK,
		"Signal not connected")
	assert(animation_player.connect(
		"animation_finished", self, "enable_rescue") == OK, 
		"Signal not connected")
	
	animated_sprite.modulate = INVADER_SELECTED_COLOR

func _input(_event):
	if returning:
		return
	direction = Vector2(
		Input.get_axis("move_left", "move_right"),
		Input.get_axis("move_up", "move_down")
	)
	direction = direction.normalized()

func _physics_process(delta):
	if returning:
		global_position = global_position.move_toward(
			unhandled.global_position, 
			delta * ACCELERATION)
		
		if (global_position - unhandled.global_position).length_squared() < 2.0:
			queue_free()
			unhandled.laser_collision_shape.disabled = false
			unhandled.visible = true
	else:
		if direction.length_squared() > 0.0:
			position = position.move_toward(position + direction * speed, delta * ACCELERATION)
		
		if can_fire and Input.is_action_pressed("fire"):
			fire()
			can_fire = false
			fire_timer.start(0.25)
		
		if can_rescue and Input.is_action_pressed("rescue") and !laser_collision_shape.disabled:
			animation_player.play("rescue")
			can_rescue = false
	._physics_process(delta)

func _on_FireTimer_timeout():
	can_fire = true

func enable_rescue(anim_name):
	if anim_name == "rescue":
		can_rescue = true

func _on_RescueArea_area_entered(area):
	if area.owner.has_method("rescued"):
		area.owner.rescued()
		rescue_collision_poly.set_deferred("disabled", true)
		emit_signal("ufo_rescued")

func _on_HandledInvader_area_entered(_area):
	die_component.start(animated_sprite)
