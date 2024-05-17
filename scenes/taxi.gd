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

func setAnimation(deg):
	var going_right = deg > 315 or deg < 45
	var going_left = deg < 225 and deg > 135
	var going_up = deg > 225 and deg < 315
	var going_down = deg > 45 and deg < 135
	
	if going_right:
		sprite_2d.animation = "go_left"
		sprite_2d.flip_h = true
	
	if going_left:
		sprite_2d.animation = "go_left"
	
	if going_up:
		sprite_2d.animation = "go_up"
		sprite_2d.flip_h = false
	
	if going_down:
		sprite_2d.animation = "go_down"
		sprite_2d.flip_h = false

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
	if velocity.x != 0 or velocity.y != 0:
		if keyDown("Left"):
			angle = move_toward(angle, angle - 45, turn)
		if keyDown("Right"):
			angle = move_toward(angle, angle + 45, turn)
	
	if keyDown("HandBreak"):
		speed = move_toward(speed, 0, deceleration * 10)
	
	# keep the angle between 0 and 360
	if abs(angle) == 360: angle = 0
	
	setAnimation(CircleRange(angle))
	
	if !keyDown("Up") and !keyDown("Down"):
		speed = move_toward(speed, 0, deceleration)
	
	velocity.x = x * speed
	velocity.y = y * speed
	
	
	move_and_slide()
