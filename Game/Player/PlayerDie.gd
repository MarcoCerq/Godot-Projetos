extends Node2D


# Defines scene to load when player dies
export(String, FILE, "*.tscn") var world_scene


var points = 0
var pointsRounded = 0
var coinsCollected = 0


# Main physics process, called every engine tick
func _physics_process(delta):
	points += delta * 2
	pointsRounded = round(points)
	$CanvasLayer/ScorePanel/Score.text = pointsRounded as String
	$CanvasLayer/CoinPanel/Coins.text = coinsCollected as String
	
	# Create self-assigning var and set it to whatever it collides with
	var bodies = $PlayerKinematicBody2D/Area2D.get_overlapping_bodies()
	
	# Loop collision for any body called "PlayerKinematicBody2D" it's bad ik
	for body in bodies:		
		if body.name == "EnemyKinematicBody2D" || body.name == "YouDied" || body.name == "RangedEnemy":
			endGame()
		if body.name == "CoinStaticBody":
			coinsCollected += 1

# Goes to main menu
func endGame():
	get_tree().change_scene(world_scene)
	
