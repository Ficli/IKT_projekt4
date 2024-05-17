extends CharacterBody2D
@onready var sprite_2d = $Sprite2D

func keyDown(key):
	return Input.is_action_pressed(key)

var speed = 300
var speedScale = 1
var acceleration = 10
var deceleration = 5
var movementScale = 1

func _physics_process(delta):
	
	if velocity.x != 0 and velocity.y != 0:
		movementScale = 2
		speedScale = move_toward(speedScale, 0.72, movementScale)
	else:
		movementScale = 1
		speedScale = 1
	
	#Handle Inputs
	if keyDown("Up"):
		velocity.y = move_toward(velocity.y, -speed * speedScale, acceleration * movementScale)
	if keyDown("Down"):
		velocity.y = move_toward(velocity.y, speed * speedScale, acceleration * movementScale)
	if keyDown("Left"):
		velocity.x = move_toward(velocity.x, -speed * speedScale, acceleration * movementScale)
	if keyDown("Right"):
		velocity.x = move_toward(velocity.x, speed * speedScale, acceleration * movementScale)
	
	if (!keyDown("Up") and !keyDown("Down")) or (keyDown("Up") and keyDown("Down")):
		velocity.y = move_toward(velocity.y, 0, deceleration)
	if !keyDown("Left") and !keyDown("Right") or (keyDown("Left") and keyDown("Right")):
		velocity.x = move_toward(velocity.x, 0, deceleration)
	
	move_and_slide()
