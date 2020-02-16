extends KinematicBody2D

var velocity
var waiter
var moving
var HP = 5
var hitTimer = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	velocity = Vector2(0,0)
	waiter = rand_range(1,3)
	moving = false

func _physics_process(delta):
	if moving:
		move_and_slide(velocity)
		
	if waiter < 0:
		waiter = rand_range(1,3)
		moving = !moving
		velocity.x = rand_range(-150,150)
		velocity.y = rand_range(-150,150)
		rotate_char(velocity.x)
	
	waiter -= delta * 2

func _process(delta):
	if hitTimer > 0:
		$Animation.play("hit")
		hitTimer -= delta
	else:
		$Animation.play("stand")
	
	if HP <= 0:
		get_node("../../Player").XP += 1
		if get_node("../../Player").XP and !get_node("../../Player").unlocked[3]:
			get_node("../../Player").unlocked[3] = true
		var cn = load("res://coin.tscn").instance()
		get_parent().add_child(cn)
		cn.global_position = global_position
		queue_free()

func rotate_char(dir):
	if dir < 0:
		$Animation.flip_h = true
	else:
		$Animation.flip_h = false

func _on_Area2D_area_entered(area):
	if area.get_parent().get_name() == "bullet":
		area.get_parent().piercer -= 1
		hit(2)

func _on_Area2D_body_entered(body):
	print("hit")
	if body.has_method("fire"):
		body.hit(1)

func hit(dmg):
	HP -= dmg
	hitTimer = 0.5
#
#func _on_Area2D_area_exited(area):
#	if area.get_parent().get_name() == "bullet":
#		hit = false