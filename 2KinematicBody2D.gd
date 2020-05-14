extends KinematicBody2D

export (int) var speed = 200

var target = Vector2()
var velocity = Vector2()
var paused = 0

func _input(event):
	if event.is_action_pressed('pause'):
		if (paused == 0):
			paused = 1
			print ("paused")
		else: 
			paused = 0
			print ("unpaused")

	if (paused == 0):
		target = get_global_mouse_position()

func _physics_process(delta):
	if (paused == 0):
		velocity = position.direction_to(target) * speed
		# look_at(target)
		if position.distance_to(target) > 5:
			velocity = move_and_slide(velocity)

