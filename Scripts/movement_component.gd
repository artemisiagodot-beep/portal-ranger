class_name MovementComponent extends Node

@export var body: CharacterBody3D
@export var movement_direction: MovementDirection
@export var look_towards_direction: LookTowardsDirection

@export var speed := 8.0
@export var acceleration := 8.0
@export var jump_velocity := 12.0
@export var gravity_multiplier := 3.0

var wants_jump := false
var enabled := true

func tick(delta: float) -> void:
	if body == null:
		return
	if not enabled:
		wants_jump = false
		return

	var direction := Vector3.ZERO
	if movement_direction:
		direction = movement_direction.get_movement_direction()

	# Smoothed movement / less snappy 
	body.velocity.x = _exponential_decay(body.velocity.x, direction.x * speed, acceleration, delta)
	body.velocity.z = _exponential_decay(body.velocity.z, direction.z * speed, acceleration, delta)

	# Gravity
	if not body.is_on_floor():
		body.velocity += body.get_gravity() * delta * gravity_multiplier

	# Jump
	if wants_jump and body.is_on_floor():
		body.velocity.y = jump_velocity
	wants_jump = false

	body.move_and_slide()

	# Face movement direction 
	if look_towards_direction and direction.length_squared() > 0.001:
		look_towards_direction.look_towards_direction(direction, delta)

func _exponential_decay(a: float, b: float, decay: float, delta: float) -> float:
	return b + (a - b) * exp(-decay * delta)
