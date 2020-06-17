extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var paused = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func pause():
	paused = 1
	pass

func unpause():
	paused = 0
	pass



func _process(_delta):
	if (paused == 0):
		$AnimationPlayer.play("unpaused")
	if (paused == 1):
		$AnimationPlayer.play("paused")
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
