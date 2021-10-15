extends Control

export(String, FILE, "*.tscn") var world_scene

func _physics_process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().change_scene(world_scene)
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()

func _on_Start_Game_pressed():
	get_tree().change_scene(world_scene)


func _on_Quit_Game_pressed():
	get_tree().quit()
