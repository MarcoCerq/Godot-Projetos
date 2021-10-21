extends KinematicBody2D

const Gravity = 50
const Speed = 200
const Floor = Vector2(0, -1)

var velocity = Vector2()

var direction = 1

func _physics_process(delta):
	velocity.x = Speed * direction
	velocity.y += Gravity
	velocity = move_and_slide(velocity, Floor)
	
	if is_on_wall():
		direction = direction * -1
		$RayCast2D.position.x *= -1
		
	if $RayCast2D.is_colliding() == false:
		direction = direction * -1
		$RayCast2D.position.x *= -1
