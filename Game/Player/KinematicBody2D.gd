extends KinematicBody2D

# Setting up movement variables
const UP = Vector2(0, -1)
const GRAVITY = 50
const ACCELERATION = 40
const MAX_SPEED = 300
const JUMP_HEIGHT = -700

var motion = Vector2()

func _physics_process(delta):
	# Gravity
	motion.y += GRAVITY
	# Friction for acceleration/deseleration
	var friction = false
	
	# If the player goes right, moves the character right and flips it's sprite right
	if Input.is_action_pressed("ui_right"):
		motion.x = min(motion.x + ACCELERATION, MAX_SPEED)
		$Sprite.flip_h = false
		$Sprite.play("Run")
	# Else if the plaery goes left, moves the character left and flips it's sprite left
	elif Input.is_action_pressed("ui_left"):
		motion.x = max(motion.x - ACCELERATION, -MAX_SPEED)
		$Sprite.flip_h = true
		$Sprite.play("Run")
	else:
	# Else makes sets it's movement to 0
		$Sprite.play("Idle")
		friction = true
		motion.x = lerp(motion.x, 0, 0.30)
	
	# Checks if player is on floor, if he is and presses UP Arrow, he'll jump
	# If player's not on floot, play fall animation
	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			motion.y = JUMP_HEIGHT
		if friction == true:
			motion.x = lerp(motion.x, 0, 0.30)
	else:
		if motion.y < 0:
			$Sprite.play("Jump")
		else:
			$Sprite.play("Fall")
		if friction == true:
			motion.x = lerp(motion.x, 0, 0.1)
	
	# Sets player's current movent/jump speed
	motion = move_and_slide(motion, UP)
	pass
