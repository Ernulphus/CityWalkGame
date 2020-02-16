extends Area2D

var nearby = false
export (int) var reward = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _input(event):
	if nearby:
		if event is InputEventKey and event.pressed and event.scancode == KEY_SPACE:
			get_node("../../Player").cash += reward
			reward = 0


func _on_rewardZone_body_entered(body):
	if body.get_name() == "Player":
		nearby = true

func _on_rewardZone_body_exited(body):
	if body.get_name() == "Player":
			nearby = false
