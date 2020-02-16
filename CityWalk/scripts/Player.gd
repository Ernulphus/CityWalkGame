extends KinematicBody2D

export (int) var speed = 200
export (int) var HP = 10
export (String) var player = "sam"
var MaxHP = 10
var cash
onready var animation = get_node(player+"Animation")
var timer = 1 # blaster cooldown timer
var hitTimer = 0 # hit animation timer
var characters = ["mich", "jada", "sam", "kadeem", "razna", "kris", "sylvia", "boaz"]
var unlocked = [true, true, false, false, false, false, false, false]
var holdFire = false


signal pause

var velocity = Vector2()

func _ready():
	for i in characters:
		get_node(i + "Animation").visible = false;
	get_node(player + "Animation").visible = true;
	animation.play("stand")
	cash = 0

func get_input():
	velocity = Vector2()
	if Input.is_action_pressed('right'):
		velocity.x += 1
	if Input.is_action_pressed('left'):
		velocity.x -= 1
	if Input.is_action_pressed('down'):
		velocity.y += 1
	if Input.is_action_pressed('up'):
		velocity.y -= 1
	velocity = velocity.normalized() * speed
	
	if Input.is_action_pressed('attack'):
		if player == "mich":
			if timer < 0:
				fire(get_global_mouse_position())
				timer = 1
		if player == "jada":
			rule_of_law(get_global_mouse_position())


func _process(delta):
	if !get_node(player + "Animation").visible:
		switch()
		switch()
	animation = get_node(player+"Animation")
	timer -= delta
	animation = get_node(player+"Animation")
	if Input.is_action_pressed("down"):
		animation.play("walkf")
	elif Input.is_action_pressed("up"):
		animation.play("walkb")
	elif Input.is_action_pressed("right"):
		animation.play("walkr")
	elif Input.is_action_pressed("left"):
		animation.play("walkl")
	else:
		animation.play("stand")
		
	if HP <= 0:
		get_tree().change_scene("MainMenu.tscn")
		
	if hitTimer > 0:
		get_node(player+"Animation").play("hit")
		hitTimer -= delta

func _input(event):
	if event is InputEventKey and event.pressed and event.scancode == KEY_Q:
		emit_signal("pause")
		
	if event is InputEventKey and event.pressed and event.scancode == KEY_E:
		switch()

func _physics_process(delta):
    get_input()
    velocity = move_and_slide(velocity)

func save():
	var save_data = {
		"filename" : get_filename(),
		"parent" : "/root/street corner",
		"pos_x" : position.x,
		"pos_y" : position.y,
		"MaxHP" : MaxHP,
		"HP" : HP,
		"player" : player,
		"cash" : cash,
		"unlocked" : unlocked
	}
	return save_data
	
func switch():
	var toBe = get_node("../Follower").follower
	get_node("../Follower").follower = player
	player = toBe
	
	for i in characters:
		if i == player:
			get_node(i + "Animation").show()
			get_node(i + "Bound").show()
		else:
			get_node(i + "Animation").hide()
			get_node(i + "Bound").hide()
		
		if i == get_node("../Follower").follower:
			get_node("../Follower/" + i + "Animation").show()
		else:
			get_node("../Follower/" + i + "Animation").hide()

func fire(target):
	if !holdFire:
		var bang = load("res://bullet.tscn").instance()
		get_parent().add_child(bang)
		var velocity = (target - global_position).normalized()
		bang.start(position, velocity)
	
func rule_of_law(target):
	var tars = get_tree().get_nodes_in_group("enemy")
	
	for i in tars:
		if (i.global_position - global_position).length() < 200:
			if (i.global_position - target).length() < 40:
				i.moving = false
				if timer < 0:
					if i.has_method("hit"):
						i.hit(1)
					timer = 0.3

func punch(target):
	pass

func hit(dmg):
	HP -= dmg
	hitTimer = 0.5
	
func changeTo(character):
	player = character
	switch()
	switch()
	