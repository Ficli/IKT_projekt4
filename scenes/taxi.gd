extends CharacterBody2D
@onready var sprite_2d = $Sprite2D

var DefSpeed = 250
var Accelerate = DefSpeed / 10
var Break = DefSpeed / 30
#var HandBreak
var directions = {
	"Up": {"state": false, "speed": ["y", -DefSpeed]},
	"Left": {"state": false, "speed": ["x", -DefSpeed]},
	"Down": {"state": false, "speed": ["y", DefSpeed]},
	"Right": {"state": false, "speed": ["x", DefSpeed]}
}


func _physics_process(delta):
	
	#Handle Inputs
	for key in directions:
		
		var axis = directions[key]["speed"][0]
		
		#Get the pressed and released buttons
		if Input.is_action_just_pressed(key):
			directions[key]["state"] = true
			
		if Input.is_action_just_released(key):
			directions[key]["state"] = false
	
		#Accelerate if the key is pressed
		if directions[key]["state"]:
			var speed = directions[key]["speed"][1]
			velocity[axis] = move_toward(velocity[axis], speed, 10)
	
	# Break if the keys are not pressed
	if not directions["Up"]["state"] and not directions["Down"]["state"]:
		velocity.y = move_toward(velocity.y, 0, Break)
	if not directions["Left"]["state"] and not directions["Right"]["state"]:
		velocity.x = move_toward(velocity.x, 0, Break)
	
	move_and_slide()
