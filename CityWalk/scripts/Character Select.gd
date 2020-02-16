extends VBoxContainer

onready var selected = 0
var characters = ["mich", "jada", "sam"]
onready var playerinst = load("res://Player.tscn").instance()
onready var followerinst = load("res://Follower.tscn").instance()

func _ready():
	add_child(playerinst)
	get_node("Player/Camera").queue_free()
	add_child(followerinst)
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
	
func select(event, nomen, index):
	if playerinst.unlocked[index]:
		if event is InputEventMouseButton and event.pressed:
			if selected == 0:
				if playerinst.player != nomen:
					playerinst.changeTo(nomen)
				selected += 1
			elif selected == 1 and playerinst.player != nomen:
				if followerinst.follower != nomen:
					followerinst.changeTo(nomen)
				selected += 1
				save_game()
				get_tree().change_scene("street corner.tscn")
	