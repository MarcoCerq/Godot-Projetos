extends Node2D

var segments = [
	preload("res://Game/LevelDesign/Segments/Segment1.tscn"),
	preload("res://Game/LevelDesign/Segments/Segment2.tscn"),
	preload("res://Game/LevelDesign/Segments/Segment3.tscn")
	#preload("res://Game/LevelDesign/Segments/Segment4.tscn")
]

var distanceBetweenSegments = 832

var lastCreatedSegment
var currentSegmentPosition = 0
var segmentAmount = 0

var hasCreatedNewSegment = false

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
	print($Player/PlayerKinematicBody2D.position.x)
	print(currentSegmentPosition)
	print(positionToDelete())
	for area in $Areas.get_children():
		if $Player/PlayerKinematicBody2D.position.x > positionToSpawn() && !hasCreatedNewSegment:
			hasCreatedNewSegment = true
			spawn_instance(area.position.x + currentSegmentPosition, 0)
	#for area in $Areas.get_children():
		#if $Player/PlayerKinematicBody2D.position.x > positionToDelete() && segmentAmount > 1 && area != lastCreatedSegment:
		#	area.queue_free()
		#	print("deleted")

func spawn_instance(x, y):
	hasCreatedNewSegment = false
	var instance = segments[randi() % len(segments)].instance()
	instance.position = Vector2(x, y)
	$Areas.add_child(instance)
	lastCreatedSegment = instance
	currentSegmentPosition += distanceBetweenSegments
	segmentAmount += 1
	
func positionToSpawn():
	return currentSegmentPosition - distanceBetweenSegments + (distanceBetweenSegments / 2)
	
func positionToDelete():
	return currentSegmentPosition - distanceBetweenSegments
