extends KinematicBody2D

var motion = Vector2();

func _physics_process(delta):
	
	if Input.is_action_pressed("ui_right"):
		motion.x = 100
	
	pass
