extends Control

# Defines scene to load when player presses Start Game
export(String, FILE, "*.tscn") var world_scene

# Main physics process, called every engine tick
func _physics_process(delta):
	menuEvent()

# Signal that gets called when player clicks "Start Game"
func _on_Start_Game_pressed():
	get_tree().change_scene(world_scene)

# Signal that gets called whne player clicks "Quit"
func _on_Quit_Game_pressed():
	get_tree().quit()

# Function that detects if the player is pressing "ui_accept" (Enter) or 
# "ui_cancel" (Esc) keys to either start the game of quit, respectively
func menuEvent():
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().change_scene(world_scene)
		
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
