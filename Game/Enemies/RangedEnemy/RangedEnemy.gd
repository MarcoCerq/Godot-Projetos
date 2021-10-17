extends KinematicBody2D

const bullet = preload("res://Game/Enemies/RangedEnemy/Bullet.tscn")

export(String) var dir = ""

var reload = 1.2
var timer = false

func _ready():
	if dir == "right":
		self.rotation_degrees = 0
	if dir == "left":
		self.rotation_degrees = 180

func _physics_process(delta):
	if timer == false:
		$Timer.start()
		timer = true

func _on_Timer_timeout():
	if timer == true:
		shoot()
		timer = false

func shoot():
	var bul = bullet.instance()
	bul.start(dir)
	self.add_child(bul)
