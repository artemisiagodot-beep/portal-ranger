class_name EvilMage extends CharacterBody3D

@onready var input_component: InputComponent = $InputComponent
@onready var movement_component: MovementComponent = $MovementComponent
@onready var health_component: HealthComponent = %HealthComponent
@onready var animation_manager: AnimationManager = %AnimationManager

func _physics_process(delta: float) -> void:
	input_component.update()
	movement_component.tick(delta)
