extends KinematicBody2D

# Setting up movement variables
const UP = Vector2(0, -1)
const GRAVITY = 50
const ACCELERATION = 40
const MAX_SPEED = 300
const JUMP_HEIGHT = -700

var jumpTimes = 0

var motion = Vector2()

var zoomStrength = 1

func _physics_process(delta):
	# Gravity
	motion.y += GRAVITY
	
	# Friction for acceleration/deseleration
	var friction = false
		
	# If the player goes right, moves the character right and 
	# flips it's sprite right
	if Input.is_action_pressed("ui_right"):
		motion.x = min(motion.x + ACCELERATION, MAX_SPEED)
		if $Camera2D.offset.x > 32:
			$Camera2D.offset.x -= 300 * delta
		$Sprite.flip_h = false
		friction = false
		$Sprite.play("Run")
	# Else if the player goes left, moves the character left and 
	# flips it's sprite left
	elif Input.is_action_pressed("ui_left"):
		#motion.x = max(motion.x - ACCELERATION, -MAX_SPEED)
		if $Camera2D.offset.x < 301:
			$Camera2D.offset.x += 300 * delta
			if not $Camera2D.offset.x > 300:
				motion.x = max(motion.x - ACCELERATION, -MAX_SPEED)
				$Sprite.flip_h = true
				$Sprite.play("Run")
				friction = false
			else:
				motion.x = 0
				$Sprite.play("Idle")
				friction = true
	else:
	# Else makes sets it's movement to 0
		$Sprite.play("Idle")
		friction = true
		
	if Input.is_action_just_released("zoom_in"):
		$Camera2D.zoom.x -= zoomStrength
		$Camera2D.zoom.y -= zoomStrength
		
	if Input.is_action_just_released("zoom_out"):
		$Camera2D.zoom.x += zoomStrength
		$Camera2D.zoom.y += zoomStrength
	
	# Checks if player is on floor, if he is and presses UP Arrow, he'll jump
	# If player's not on floor, play fall animation	
	if is_on_floor():
		if jumpTimes > 0:
			jumpTimes = 0
	
	if motion.y < 0:
		$Sprite.play("Jump")
	elif motion.y > 50:
		$Sprite.play("Fall")
	
	if jumpTimes < 2:
		if Input.is_action_just_pressed("ui_up"):
			motion.y = JUMP_HEIGHT
			jumpTimes += 1
	
	if friction == true:
		motion.x = lerp(motion.x, 0, 0.30)
	else:
		motion.x = lerp(motion.x, 0, 0.10)
	
	# Sets player's current movent/jump speed
	motion = move_and_slide(motion, UP)
