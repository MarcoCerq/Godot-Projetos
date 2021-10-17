extends KinematicBody2D

var speed = 250
var motion = Vector2()

func _ready():
	$lifetime.start()
	global_position = get_parent().global_position
	

func start(dir):
	if dir == "left" || dir == "right":
		$Sprite.rotation_degrees = 90
		if dir == "left":
			motion.x = -speed
		else:
			motion.x = speed

func _physics_process(delta):
	motion = move_and_slide(motion)


func _on_lifetime_timeout():
	queue_free()
