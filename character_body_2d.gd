extends CharacterBody2D
@export var speed = 400
var hp = 100

func get_input():
	var input_direcction = Input.get_vector("Left","Right","Up","Down")
	velocity = input_direcction * speed
	
func _physics_process(delta: float) -> void:
	get_input()
	move_and_slide()
