extends Popup

func _ready():
	pass

func _input(event):
	if event is InputEventKey and event.pressed:
		popup()
		print("alkjdf")