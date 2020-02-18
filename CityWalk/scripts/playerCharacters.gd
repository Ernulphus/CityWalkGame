extends Node2D

var dict : Dictionary
var index = 2
var met = [false, false, false, false]
var most_recent

func _ready():
	for i in met:
		if i:
			get_node(get_node("../Player").characters[i - 2]).queue_free()

func _on_samArea_body_entered(body):
	most_recent = 2
	index = 2
	get_node("../dialogue/DialogBox").dialog_hide_on_ok = false
	if body.get_name() == "Player":
		dict = load_dialogue("res://dialogues/samRecruit.json")
		get_node("../dialogue/DialogBox").popup()
		get_tree().paused = true
		for i in dict["1"]:
			if i == "name":
				get_node("../dialogue/DialogBox/TextureRect").texture = load("res://animations/"+i+"stand1.png")
			if i == "text":
				get_node("../dialogue/DialogBox").dialog_text = dict["1"][i]

func load_dialogue(file_path) -> Dictionary:
	var dialogue = File.new()
	dialogue.open(file_path, dialogue.READ)
	var dialog = parse_json(dialogue.get_as_text())
	return dialog

func _on_DialogBox_confirmed():
	print(index)
	if index == dict.size():
		print("next to last one")
		get_node("../dialogue/DialogBox").dialog_hide_on_ok = true
	
	if index == dict.size() + 1:
		print("last one")
		get_tree().paused = false
		get_node(get_node("../Player").characters[most_recent]).queue_free()
		get_node("../Player").unlocked[most_recent] = true
		met[most_recent - 2] = true
		index = 2
		return
		
	for i in dict[str(index)]:
		print("next sentence")
		if i == "name":
			get_node("../dialogue/DialogBox/TextureRect").texture = load("res://animations/"+i+"stand1.png")
		if i == "text":
			get_node("../dialogue/DialogBox").dialog_text = dict[str(index)][i]
	index += 1

func save():
	var save_data = {
		"filename" : get_filename(),
		"parent" : "/root/street corner",
		"pos_x" : position.x,
		"pos_y" : position.y,
		"met" : met
	}
	return save_data