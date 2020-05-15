extends KinematicBody2D

export (int) var speed = 200

var velocity = Vector2()
var paused = 0

func get_input():
	if Input.is_action_just_pressed("pause"):
		if (paused == 0):
			paused = 1
		else:
			paused = 0
	if (paused == 0):
		rotation = get_global_mouse_position().angle_to_point(position)
		velocity = Vector2()
		if Input.is_action_pressed('ui_right'):
			velocity.x += 1
		if Input.is_action_pressed('ui_left'):
			velocity.x -= 1
		if Input.is_action_pressed('ui_down'):
			velocity.y += 1
		if Input.is_action_pressed('ui_up'):
			velocity.y -= 1
		velocity = velocity.normalized() * speed
		

func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity)
