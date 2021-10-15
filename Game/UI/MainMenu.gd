extends Control

export(String, FILE, "*.tscn") var world_scene


func _on_Start_Game_pressed():
	get_tree().change_scene(world_scene)


func _on_Quit_Game_pressed():
	get_tree().quit()
