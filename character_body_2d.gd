extends CharacterBody2D
var hp = 100

const speed = 400
const accel = 1500
const friction = 600

var input = Vector2.ZERO

func _physics_process(delta):
	player_movement(delta)

func get_input():
	input.x = int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))
	input.y = int(Input.is_action_pressed("down")) - int(Input.is_action_pressed("up"))
	return input.normalized()
	
func player_movement(delta):
	input = get_input()
	
	if input == Vector2.ZERO:
		if velocity.length() > (friction * delta):
			velocity -= velocity.normalized() * (friction * delta)
		else:
			velocity = Vector2.ZERO
	else :
		velocity += (input * accel * delta)
		velocity = velocity.limit_length(speed)
		
	move_and_slide()
