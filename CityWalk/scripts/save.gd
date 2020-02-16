extends ConfirmationDialog


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func _on_SaveOption_gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		popup_centered()