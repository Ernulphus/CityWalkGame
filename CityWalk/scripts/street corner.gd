extends Node2D

func _ready():
	OS.set_window_size(Vector2(900,600))
	load_game()

func load_game():
	var save_game = File.new()
	
	#revert game state so we don't clone objects
	var save_nodes = get_tree().get_nodes_in_group("Persist")
	for i in save_nodes:
		i.free()
		
	if not save_game.file_exists("res://saves/savegame.save"):
		print("no previous save found")
		add_child(load("res://Follower.tscn").instance())
		$Follower.changeTo("jada")
		add_child(load("res://Player.tscn").instance())
		$Player.changeTo("mich")
		return # We don't have a save to load.

    # Load the file line by line and process that dictionary to restore
    # the object it represents.
	save_game.open("res://saves/savegame.save", File.READ)
	while not save_game.eof_reached():
		var current_line = parse_json(save_game.get_line())
		# Firstly, we need to create the object and add it to the tree and set its position.
		if current_line != null:
			print(current_line)
			var new_object = load(current_line["filename"]).instance()
			#get_node(current_line["parent"]).
			add_child(new_object)
			new_object.position = Vector2(current_line["pos_x"], current_line["pos_y"])
			# Now we set the remaining variables.
			for i in current_line.keys():
				if i == "follower":
					new_object.changeTo(current_line[i])
					continue
				if i == "filename" or i == "parent" or i == "pos_x" or i == "pos_y" or i == "follower":
					continue
				new_object.set(i, current_line[i])
	save_game.close()