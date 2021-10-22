extends KinematicBody2D


var speed = 250
var motion = Vector2()


# Defines scene to load when player dies
export(String, FILE, "*.tscn") var world_scene


func _ready():
	$lifetime.start()
	global_position = get_parent().global_position


func start(dir):
	if dir == "left" || dir == "right":
		if dir == "left":
			motion.x = -speed
			self.rotation_degrees = 90
		else:
			motion.x = speed
			self.rotation_degrees = -90


func _physics_process(delta):
	motion = move_and_slide(motion)
	
	var bodies = $Area2D.get_overlapping_bodies()
	
	for body in bodies:
		if body.name == "PlayerKinematicBody2D":
			self.queue_free()
			get_tree().change_scene(world_scene)
		elif body.name != "RangedEnemy" && body.name != "EnemyKinematicBody2D":
			self.queue_free()


func _on_lifetime_timeout():
	queue_free()
