extends KinematicBody2D

var speed = 600
var velocity = Vector2()
var piercer = 3


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func _physics_process(delta):
	var collision = move_and_collide(velocity * delta * speed)
	if collision:
		if collision.collider.get_class() == "TileMap" || collision.collider.get_name() == "subway":
			queue_free()
	if piercer <= 0:
		queue_free()
	
func start(pos, dir):
	position = pos
	velocity = dir
