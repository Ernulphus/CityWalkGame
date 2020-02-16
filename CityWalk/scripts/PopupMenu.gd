extends PopupMenu

func _ready():
	pass

func _input(event):
	if event is InputEventKey and event.pressed and event.scancode == KEY_Q:
		if visible:
			visible = false
			get_tree().paused = false
		else:
			popup()
			get_tree().paused = true