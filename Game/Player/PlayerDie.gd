extends Node2D

export(String, FILE, "*.tscn") var world_scene

func _physics_process(delta):
	# Create self-assigning var and set it to whatever it collides with
	var bodies = $PlayerKinematicBody2D/Area2D.get_overlapping_bodies()
	
	# Loop collision for any body called "PlayerKinematicBody2D" it's bad ik
	for body in bodies:
		if body.name == "EnemyKinematicBody2D" || body.name == "YouDied":
			get_tree().change_scene(world_scene)
	
	#if Input.is_action_just_pressed("ui_cancel"):
		#get_tree().change_scene(world_scene)
