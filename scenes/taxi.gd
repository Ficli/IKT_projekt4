extends CharacterBody2D
@onready var sprite_2d = $Sprite2D


func keyDown(key: String):
	return Input.is_action_pressed(key)

func toRad(deg: float):
	return (PI / 180) * deg

func CircleRange(num):
	if num < 0:
		num = ceil(abs(num) / 360) * 360 + num
	if num > 360:
		num = (num / 360 - int(num / 360)) * 360
	return num

func setAnimation(deg, speed):
	var states = {
		"right": [deg > 315 or deg < 45, "left", true],
		"left": [deg < 225 and deg > 135, "left", false],
		"up": [deg > 225 and deg < 315, "up", false],
		"down": [deg > 45 and deg < 135, "down", false],
	}
	var forward = speed > 0
	
	for direction in states:
		if states[direction][0]:
			var flip_h = states[direction][2]
			var anim = states[direction][1]
			
			if speed != 0: anim = "go_" + anim
			else: anim = "stand_" + anim
			sprite_2d.animation = anim
			sprite_2d.flip_h = flip_h
	
			
var angle = 0
var turn = 2.5
var MaxSpeed = 400
var speed = 0
var acceleration = MaxSpeed * 0.02
var deceleration = MaxSpeed * 0.005

func _physics_process(delta):
	
	# x and y axis speed
	var x = cos( toRad(angle) )
	var y = sin( toRad(angle) )
	
	# move forwards and backwards
	if keyDown("Up"):
		speed = move_toward(speed, MaxSpeed, acceleration)
	if keyDown("Down"):
		speed = move_toward(speed, -MaxSpeed / 2, acceleration)
	
	# turn if the car is moving
	if speed > 0:
		if keyDown("Left"):
			angle = move_toward(angle, angle - 45, turn)
		if keyDown("Right"):
			angle = move_toward(angle, angle + 45, turn)
	else:
		if keyDown("Left"):
			angle = move_toward(angle, angle + 45, turn)
		if keyDown("Right"):
			angle = move_toward(angle, angle - 45, turn)
	
	if keyDown("HandBreak"):
		speed = move_toward(speed, 0, deceleration * 10)
	
	# keep the angle between 0 and 360
	if abs(angle) == 360: angle = 0
	
	setAnimation(CircleRange(angle), speed)
	
	if !keyDown("Up") and !keyDown("Down"):
		speed = move_toward(speed, 0, deceleration)
	
	velocity.x = x * speed
	velocity.y = y * speed
	
	
	move_and_slide()
