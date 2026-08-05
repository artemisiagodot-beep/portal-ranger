extends CharacterBody3D

@onready var input_component: InputComponent = $InputComponent
@onready var movement_component: MovementComponent = $MovementComponent

func _physics_process(delta: float) -> void:
	input_component.update()
	movement_component.tick(delta)
