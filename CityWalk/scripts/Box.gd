extends HSplitContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Exit_gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		get_tree().quit()

func _on_Continue_gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		get_tree().change_scene("street corner.tscn")

func _on_New_Game_gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		var dir = Directory.new()
		dir.remove("res://saves/savegame.save")
		get_tree().change_scene("street corner.tscn")
