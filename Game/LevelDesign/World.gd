extends Node2D

# Defining scenes to be assigned
export(String, FILE, "*.tscn") var world_scene
export(String, FILE, "*.tscn") var reset_scene

# Preloading coin for connceting signals to player
var coinInstance = preload("res://Game/Items/Coin.tscn")

# Defining chunk presets
var segments = [
	preload("res://Game/LevelDesign/Segments/Segment1.tscn"),
	preload("res://Game/LevelDesign/Segments/Segment2.tscn"),
	preload("res://Game/LevelDesign/Segments/Segment3.tscn"),
	preload("res://Game/LevelDesign/Segments/Segment4.tscn"),
	preload("res://Game/LevelDesign/Segments/Segment5.tscn"),
	preload("res://Game/LevelDesign/Segments/Segment6.tscn"),
	preload("res://Game/LevelDesign/Segments/Segment7.tscn"),
	preload("res://Game/LevelDesign/Segments/Segment8.tscn"),
	preload("res://Game/LevelDesign/Segments/Segment9.tscn"),
	preload("res://Game/LevelDesign/Segments/Segment10.tscn"),
	preload("res://Game/LevelDesign/Segments/Segment11.tscn"),
	preload("res://Game/LevelDesign/Segments/Segment12.tscn"),
	preload("res://Game/LevelDesign/Segments/Segment13.tscn"),
	preload("res://Game/LevelDesign/Segments/Segment14.tscn"),
	preload("res://Game/LevelDesign/Segments/Segment15.tscn"),
	preload("res://Game/LevelDesign/Segments/Segment16.tscn")
]

# Defining variables
var distanceBetweenSegments = 832
var lastCreatedSegment
var currentSegmentPosition = 0
var hasCreatedNewSegment = true

# Created a random chunk when ready
func _ready():
	spawn_instance(0, 0)

# Main physics process, called every engine tick
func _physics_process(delta):
	generateNewChunk()
	
	menuEvent()

# Function that Generates New Chunks of map when required circumstances are met
func generateNewChunk():
	for area in $Areas.get_children():
		if $Player/PlayerKinematicBody2D.position.x >= positionToSpawn() && not hasCreatedNewSegment:
			hasCreatedNewSegment = true
			spawn_instance(currentSegmentPosition + distanceBetweenSegments, 0)
			delete_instance()

# Generates new chunk
func spawn_instance(x, y):
	if hasCreatedNewSegment:
		hasCreatedNewSegment = false
		var instance = segments[randi() % len(segments)].instance()
		instance.position = Vector2(x, y)
		$Areas.add_child(instance)
		lastCreatedSegment = instance
		currentSegmentPosition = instance.position.x
		for child in instance.get_children():
			child.connect("coinCollected", $Player, "_on_CoinArea2D_coinCollected")

# Deletes old chunk
func delete_instance():
	for area in $Areas.get_children():
		if area.position.x < positionToDelete():
			if area != lastCreatedSegment:
				if area.position.x < $Player/PlayerKinematicBody2D.position.x:
					area.queue_free()

# Defines the position the next chunk must be generated in
func positionToSpawn():
	var halfDistance = distanceBetweenSegments / 2
	return currentSegmentPosition - halfDistance

# Defines the position the chunk must be in to be deleted
func positionToDelete():
	var doubleDistance = distanceBetweenSegments * 2
	return currentSegmentPosition - doubleDistance

# Function that detects if the player is pressing "ui_cancel" (Esc) or 
# "ui_reset" (R) keys to either quit the game or restart the game respectively
func menuEvent():
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().change_scene(world_scene)
		
	if Input.is_action_just_pressed("ui_reset"):
		get_tree().change_scene(reset_scene)
