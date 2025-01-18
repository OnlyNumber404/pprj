extends CharacterBody2D

const SPEED = 700.0
const JUMP_VELOCITY = -1800.0
const GRAVITY = Vector2(0, 8000)

var jump_available: bool = true

@onready var coyote_timer: Timer = $coyote_timer

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += GRAVITY * delta
		if jump_available:
			if coyote_timer.is_stopped():
				coyote_timer.start()
	else:
		jump_available = true
		coyote_timer.stop()
	# Handle jump.
	if Input.is_action_just_pressed("jump") and jump_available:
		velocity.y = JUMP_VELOCITY
	
	if velocity.y > 0 and velocity.y < 600:
		velocity.y += 40
	
	var direction := Input.get_axis("left", "right")
	velocity.x = move_toward(velocity.x, SPEED * direction, SPEED * 0.3)
	move_and_slide()

func _on_coyote_timer_timeout() -> void:
	jump_available = false
