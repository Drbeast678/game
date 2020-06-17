extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var paused = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.
	
func _input(event):
	if (event.is_action_pressed("pause")):
		if (paused == 0):
			paused = 1
			print("paused")
		else:
			paused = 0
			print("unpaused")
	
	if (paused == 1):
		$character.pause()
		$Sprite.pause()
	if (paused == 0):
		$character.unpause()
		$Sprite.unpause()
		



	pass
func hurt():
	$gui.hurt()
	pass
