extends KinematicBody2D

var speed = 200

var Bullet = preload("res://bullet.tscn")

var velocity = Vector2()
var paused = 0
var maxAmmo = 20
var ammo1 = 20
var ammo2 = 50
var reloading = 0
var gun = 1
var reloadSpeed = 2
var shooting = 0
var health = 50

func pause():
	paused = 1
	pass

func unpause():
	paused = 0
	pass


func get_input():
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
		
		
		if Input.is_action_just_pressed("click"):
			if (gun == 1):
				if (ammo1 > 0):
					if(reloading == 0):
						shoot()
			if(reloading == 1):
				print($reloadTimer.time_left)


		if Input.is_action_pressed("click"):
			if (gun == 2):
				if (ammo2 > 0):
					if(reloading == 0):
						shooting = 1
				else:
					shooting = 0
			if(reloading == 1):
				shooting = 0
				print($reloadTimer.time_left)
		else:
			shooting = 0

		if Input.is_action_just_pressed("reload"):
			if (reloadSpeed == 2):
				if (ammo1 < 20):
					$reloadTimer.wait_time = 0.5
					$AnimationPlayer.play("reload")
					reloading = 1
					print("reloading")
			if (reloadSpeed == 1):
				if (ammo2 < 50):
					$reloadTimer.wait_time = 1
					$AnimationPlayer.play("reload2")
					reloading = 1
					print("reloading")
			$reloadTimer.start()

#testing keys    disable when done
		if Input.is_action_just_pressed("gun+"):
			gun = 1
			gunswap()
		if Input.is_action_just_pressed("gun-"):
			gun = 2
			gunswap()
		if Input.is_action_just_pressed("reloadSpeed+"):
			reloadSpeed += 1
		if Input.is_action_just_pressed("reloadSpeed-"):
			reloadSpeed -= 1


func _on_shoottimer_timeout():
	if (shooting == 1):
		shoot()

func _on_reloadTimer_timeout():
#	$AnimationPlayer.play("reload")
	if (gun == 1):
		reloading = 0
		ammo1 = maxAmmo
		$ammo.value = 20
		$ammo.max_value = 20
		print(ammo1, "/", maxAmmo)
	if (gun == 2):
		reloading = 0
		ammo2 = maxAmmo
		$ammo.value = 50
		$ammo.max_value = 50
		print(ammo2, "/", maxAmmo)

func shoot():
	$ammo.value -= 1
	var b = Bullet.instance()
	b.start($Muzzle.global_position, rotation)
	get_parent().add_child(b)

	if (gun == 1):
		ammo1 -= 1
		print(ammo1, "/", maxAmmo)

	if (gun == 2):
		ammo2 -= 1
		print(ammo2, "/", maxAmmo)
	
	
func gunswap():
	if (gun == 1):
		$ammo.value = ammo1
		$ammo.max_value = 20
		$AnimationPlayer.play("pistol")
		maxAmmo = 20
		reloadSpeed = 2

	if (gun == 2):
		$ammo.value = ammo2
		$ammo.max_value = 50
		$AnimationPlayer.play("fast pistol")
		maxAmmo = 50
		reloadSpeed = 1
		$ammo.value = ammo2
		$ammo.max_value = 50



func _physics_process(_delta):
	if (paused == 0):
		get_input()
		velocity = move_and_slide(velocity)



func Game_over():
	if (health == 0):
		print("ded")
		pass


func _on_Area2D_body_entered(body):
#	print("hit")
	health -= 1
	print(health)
	$TextureProgress.value = health*2
	Game_over()
	pass # Replace with function body.
