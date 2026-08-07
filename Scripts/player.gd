class_name Player extends CharacterBody3D

@onready var input_component: InputComponent = %InputComponent
@onready var movement_component: MovementComponent = %MovementComponent
@onready var health_component: HealthComponent = %HealthComponent
@onready var camera_rotation: CameraRotation = %CameraRotation
@onready var spring_arm_3d_interpolation: SpringArm3DInterpolation = $SpringArm3DInterpolation

func take_damage(amount: float) -> void:
	health_component.damage(amount)

func _physics_process(delta: float) -> void:
	# Read controls
	input_component.update()

	# Move Character
	movement_component.wants_jump = input_component.jump_pressed
	movement_component.tick(delta)
	
	#Rotate Camera
	camera_rotation.frame_camera_rotation()
	spring_arm_3d_interpolation.sprint_arm_interpolation(delta)
	
	
