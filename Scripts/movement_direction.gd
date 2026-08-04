class_name MovementDirection extends Node

@export var horizontal_pivot: Node3D
@export var input_component: InputComponent

func get_movement_direction() -> Vector3:
	var input_vector := Vector3(input_component.move_dir.x, 0, input_component.move_dir.y).normalized()
	return horizontal_pivot.global_transform.basis * input_vector
