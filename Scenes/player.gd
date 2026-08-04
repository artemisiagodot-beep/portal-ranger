class_name Player extends CharacterBody3D

@onready var input_component: InputComponent = %InputComponent
@onready var movement_component: MovementComponent = %MovementComponent
@onready var health_component: HealthComponent = %HealthComponent
@onready var camera_rotation: CameraRotation = %CameraRotation
func _ready() -> void:
	health_component.died.connect(_on_died)

func _physics_process(delta: float) -> void:
	# Read controls
	input_component.update()

	# Move Character
	movement_component.wants_jump = input_component.jump_pressed
	movement_component.tick(delta)
	
	#Rotate Camera
	camera_rotation.frame_camera_rotation()
	if input_component.hurt_pressed:
		health_component.damage(10)
	if input_component.heal_pressed:
		health_component.heal(10)

func _on_died() -> void:
	print("player is dead")
