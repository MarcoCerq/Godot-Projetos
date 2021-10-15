extends Node2D

export(String, FILE, "*.tscn") var world_scene
export(String, FILE, "*.tscn") var reset_scene

var segments = [
	preload("res://Game/LevelDesign/Segments/Segment1.tscn"),
	preload("res://Game/LevelDesign/Segments/Segment2.tscn"),
	preload("res://Game/LevelDesign/Segments/Segment3.tscn")
	#preload("res://Game/LevelDesign/Segments/Segment4.tscn")
]

var distanceBetweenSegments = 832

var lastCreatedSegment
var currentSegmentPosition = 0

var hasCreatedNewSegment = true

var speed = 200

func _ready():
	randomize()
	spawn_instance(0, 0)
	#currentSegmentPosition += distanceBetweenSegments

#func _physics_process(delta):
	#for area in $Areas.get_children():
		#area.position.x -= speed * delta
		#if area.position.x < -distanceBetweenSegments:
			#spawn_instance(area.position.x + (distanceBetweenSegments * 2), 0)
			#area.queue_free()
		#if($Player/PlayerKinematicBody2D.position.x > lastCreatedSegment.position.x - 164):
			#oldPosition += distanceBetweenSegments
			#spawn_instance(area.position.x + (oldPosition + distanceBetweenSegments), 0)
	#for area in $Areas.get_children():
		#var distancetoplayer = area.position.distance_to($Player/PlayerKinematicBody2D.distance)
			#if distancetoplayer > distanceBetweenSegments:
				#area.queue_free

func _physics_process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().change_scene(world_scene)
	if Input.is_action_just_pressed("ui_reset"):
		get_tree().change_scene(reset_scene)
	for area in $Areas.get_children():
		if $Player/PlayerKinematicBody2D.position.x >= positionToSpawn() && not hasCreatedNewSegment:
			hasCreatedNewSegment = true
			spawn_instance(area.position.x + currentSegmentPosition, 0)
			delete_instance()

func spawn_instance(x, y):
	if hasCreatedNewSegment:
		hasCreatedNewSegment = false
		var instance = segments[randi() % len(segments)].instance()
		instance.position = Vector2(x, y)
		$Areas.add_child(instance)
		lastCreatedSegment = instance
		currentSegmentPosition += distanceBetweenSegments
		
func delete_instance():
	for area in $Areas.get_children():
		if area.position.x <= positionToDelete() && area.get_node("VisibilityNotifier2D").is_on_screen():
			area.queue_free()
	
func positionToSpawn():
	return currentSegmentPosition - distanceBetweenSegments + (distanceBetweenSegments / 2)
	
func positionToDelete():
	return currentSegmentPosition - distanceBetweenSegments - (distanceBetweenSegments * 2)
