class_name CameraRotation extends Node

@export var horizontal_pivot : Node3D
@export var vertical_pivot : Node3D
@export var min_boundary: float = -60
@export var max_boundary: float = 10
@export var mouse_sensitivity: float = 0.00075
var _look := Vector2.ZERO

func _unhandled_input(event: InputEvent) -> void:
	if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			_look = -event.relative * mouse_sensitivity

func frame_camera_rotation() -> void:
	horizontal_pivot.rotate_y(_look.x)
	vertical_pivot.rotate_x(_look.y)
	
	vertical_pivot.rotation.x = clampf(
		vertical_pivot.rotation.x, 
		deg_to_rad(min_boundary), 
		deg_to_rad(max_boundary)
		)
	
	_look = Vector2.ZERO
	
	
