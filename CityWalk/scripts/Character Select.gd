extends VBoxContainer

onready var selected = 0
var characters = ["mich", "jada", "sam"]
var playerinst
var followerinst

func _ready():
	playerinst = load("res://Player.tscn").instance()
	followerinst = load("res://Follower.tscn").instance()
	add_child(playerinst)
	add_child(followerinst)
	save_game()
#	load_game()
	get_node("Player/Camera").queue_free()
	$Player.hide()
	$Player.holdFire = true
	$Follower.hide()

func _on_mich_gui_input(event):
	select(event, "mich", 0)

func _on_jada_gui_input(event):
	select(event, "jada", 1)

func _on_sam_gui_input(event):
	select(event, "sam", 2)

func _on_kadeem_gui_input(event):
	select(event, "kadeem", 3)

func _on_razna_gui_input(event):
	select(event, "razna", 4)

func _on_kristian_gui_input(event):
	select(event, "kris", 5)

func _on_boaz_gui_input(event):
	select(event, "boaz", 6)

func _on_sylvia_gui_input(event):
	select(event, "sylvia", 7)

func save_game():
	var save_game = File.new()
	save_game.open("res://saves/savegame.save", File.WRITE)
	var save_nodes = get_tree().get_nodes_in_group("Persist")
	for i in save_nodes:
		var node_data = i.call("save")
		save_game.store_line(to_json(node_data))
	save_game.close()
#func save_game():
#	var save_game = File.new()
#	save_game.open("res://saves/savegame.save", File.READ)
#
#	while not save_game.eof_reached():
#		var current_line = parse_json(save_game.get_line())
#		if current_line != null:
#			for i in current_line:
#				if i == "player":
#					current_line["player"] = playerinst.player
#				if i == "follower":
#					current_line["follower"] = followerinst.follower
#	save_game.close()
	
func select(event, nomen, index):
	if playerinst.unlocked[index]:
		if event is InputEventMouseButton and event.pressed:
			if selected == 0:
				playerinst.changeTo(nomen)
				selected += 1
			elif selected == 1:
				if playerinst.player != nomen:
					followerinst.changeTo(nomen)
					selected += 1
					save_game()
					var backToWorld = load("res://street corner.tscn")
					get_tree().change_scene_to(backToWorld)

func load_game():
	var save_game = File.new()
	
	#revert game state so we don't clone objects
	var save_nodes = get_tree().get_nodes_in_group("Persist")
	for i in save_nodes:
		i.free()
		
#	if not save_game.file_exists("res://saves/savegame.save"):
#		print("no previous save found")
#		add_child(load("res://Follower.tscn").instance())
#		add_child(load("res://Player.tscn").instance())
#		return # We don't have a save to load.

    # Load the file line by line and process that dictionary to restore
    # the object it represents.
	save_game.open("res://saves/savegame.save", File.READ)
	while not save_game.eof_reached():
		var current_line = parse_json(save_game.get_line())
		# Firstly, we need to create the object and add it to the tree and set its position.
		if current_line != null:
			var new_object = load(current_line["filename"]).instance()
			#get_node(current_line["parent"]).
			add_child(new_object)
			new_object.position = Vector2(current_line["pos_x"], current_line["pos_y"])
			# Now we set the remaining variables.
			for i in current_line.keys():
#				if i == "follower":
#					new_object.changeTo(current_line[i])
#					continue
				if i == "filename" or i == "parent" or i == "pos_x" or i == "pos_y":
					continue
				new_object.set(i, current_line[i])
	save_game.close()


func _on_stop1_gui_input(event):
	$Player.position = Vector2(0,0)


func _on_stop2_gui_input(event):
	$Player.position = Vector2(3000, 7850)
