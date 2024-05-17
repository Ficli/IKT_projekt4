extends CharacterBody2D
@onready var sprite_2d = $Sprite2D

func keyDown(key: String):
	return Input.is_action_pressed(key)
func toRad(deg: float):
	return (PI / 180) * deg
func toDeg(rad: float):
	return (180 / PI) * rad


var angle = 0
var turn = 2
var MaxSpeed = 400
var speed = 0
var acceleration = MaxSpeed * 0.01
var deceleration = MaxSpeed * 0.005

func _physics_process(delta):
	
	var x = cos( toRad(angle) )
	var y = sin( toRad(angle) )
	
	if keyDown("Up"):
		speed = move_toward(speed, MaxSpeed, acceleration)
	if keyDown("Left"):
		angle = move_toward(angle, angle - 45, turn)
	if keyDown("Right"):
		angle = move_toward(angle, angle + 45, turn)
	if keyDown("Down"):
		speed = move_toward(speed, -MaxSpeed / 2, acceleration)
	
	if !keyDown("Up") and !keyDown("Down"):
		speed = move_toward(speed, 0, deceleration)
	
	velocity.x = x * speed
	velocity.y = y * speed
	
	
	move_and_slide()
