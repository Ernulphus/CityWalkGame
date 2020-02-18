extends KinematicBody2D

export (int) var speed
var direction
var target
export (String) var follower = "jada"
onready var animation = get_node(follower+"Animation")
var turnTimer = 0.5
var characters = ["mich", "jada", "sam", "kadeem", "razna", "kris", "sylvia", "boaz"]

# Called when the node enters the scene tree for the first time.
func _ready():
	speed = 4.75
	animation.play("stand")

func _physics_process(delta):
	
	if get_node("../Player") != null:
		target = get_node("../Player").position
	turnTimer -= delta
	
	if (target-position).length() < 75:
		animation.play("stand")
	elif (target-position).length() > 700:
		position = target
	else:
		direction = (target - position).normalized() * speed
		if turnTimer < 0:
			turn(direction)
			turnTimer = 0.5
		move_and_collide(direction)

		
func turn(dir):
	animation = get_node(follower+"Animation")
	if  dir.x < 3.5 && dir.x > -3.5:
		if dir.y > 3.5:
			animation.play("walkf")
		if dir.y < -3.5:
			animation.play("walkb")
	elif dir.y < 3.5 && dir.y > -3.5:
		if dir.x < 3.5:
			animation.play("walkl")
		if dir.x > 3.5:
			animation.play("walkr")

func changeTo(character):
	follower = character
	for i in characters:
		if i == follower:
			get_node(i + "Animation").show()
		else:
			get_node(i + "Animation").hide()

func save():
	var save_data = {
		"filename" : get_filename(),
		"parent" : "/root/street corner",
		"pos_x" : position.x,
		"pos_y" : position.y,
		"follower" : follower
	}
	return save_data
	
func selectsave():
	var save_data = {
		"follower" : follower
	}
	return save_data