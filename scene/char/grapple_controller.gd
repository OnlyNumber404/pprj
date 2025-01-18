extends Node2D

@export var rest_length := 2.0
@export var stiffness := 10.0
@export var damping := 2.0

@onready var player := get_parent()
@onready var tounge_ray := $RayCast2D
@onready var tounge := $tongue

var target: Vector2
var launched := false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	tounge_ray.look_at(get_global_mouse_position())

	if Input.is_action_just_pressed("shoot"):
		if tounge_ray.is_colliding():
			launched = true
			target = tounge_ray.get_collision_point()

	if Input.is_action_just_released("shoot"):
		launched = false
	
	if launched:
		grapple_handle(delta)

func grapple_handle(delta: float) -> void:
# grappling logic
	var target_dir = player.global_position.direction_to(target)
	var target_dist = player.global_position.distance_to(target)

	var displacement = (target_dist) - rest_length

	var force = Vector2.ZERO

	if displacement > 0:
		var spring_force_magnitude = stiffness * displacement
		var spring_force = target_dir * spring_force_magnitude
		
		var vel_dot = player.velocity.dot(target_dir)
		var Damping = -damping * vel_dot * target_dir
		
		force = spring_force + Damping
	player.velocity += force * delta
	print(displacement)
	
	tounge.set_point_position(1, to_local(target))
# grappling logic end
