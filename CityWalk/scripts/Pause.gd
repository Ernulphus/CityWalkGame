extends CanvasLayer

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_PauseMenu_about_to_show():
	var stats = $PauseMenu/PauseMenuItems/Stats
	stats.clear()
	var player = get_node("../Player")
	print(player)
	stats.add_text("HP: " + str(player.HP) + " / " + str(player.MaxHP))
	stats.add_text("\n" + "$" + str(player.cash))
