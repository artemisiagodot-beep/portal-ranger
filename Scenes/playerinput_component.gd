class_name PlayerInputComponent extends InputComponent

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
func update() -> void:
	move_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	jump_pressed = Input.is_action_just_pressed("jump")
	hurt_pressed = Input.is_action_just_pressed("hurt")
	heal_pressed = Input.is_action_just_pressed("heal")

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		else:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
