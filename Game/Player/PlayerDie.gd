extends Node2D

# Defines scene to load when player dies
export(String, FILE, "*.tscn") var world_scene

# Defining variables
var points = 0
var pointsRounded = 0
var coinsCollected = 0

# Setting Coin and Score texts to 0 on game start
func _ready():
	$CanvasLayer/CoinPanel/Coins.text = coinsCollected as String
	$CanvasLayer/ScorePanel/Score.text = pointsRounded as String

# Main physics process, called every engine tick
func _physics_process(delta):
	points += delta * 2
	pointsRounded = round(points)
	$CanvasLayer/ScorePanel/Score.text = pointsRounded as String
	
	# Create self-assigning var and set it to whatever it collides with
	var bodies = $PlayerKinematicBody2D/Area2D.get_overlapping_bodies()
	
	# Loop collision for any body called "PlayerKinematicBody2D" it's bad ik
	for body in bodies:
		if body.name == "EnemyKinematicBody2D" || body.name == "YouDied" || body.name == "RangedEnemy":
			endGame()

# Goes to main menu
func endGame():
	get_tree().change_scene(world_scene)

# When signalled, will add 1 coin to the player total coins
func _on_CoinArea2D_coinCollected():
	coinsCollected += 1
	_ready()
