extends KinematicBody2D

var inputThing = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_Area2D_body_entered(body):
	if body.get_name() == "Player":
		body.HP = body.MaxHP
		inputThing = body
		
func _input(event):
	if event is InputEventKey and event.scancode == KEY_SPACE and typeof(inputThing) == TYPE_OBJECT:
		if inputThing.get_name() == "Player":
			print("going to charselect")
			get_tree().change_scene("Character Select.tscn")
	
func save():
	var save_game = File.new()
	save_game.open("res://saves/savegame.save", File.WRITE)
	var save_nodes = get_tree().get_nodes_in_group("Persist")
	for i in save_nodes:
		var node_data = i.call("save")
		save_game.store_line(to_json(node_data))
	save_game.close()

func _on_Area2D_body_exited(body):
	if body.get_name() == "Player":
		inputThing = 0