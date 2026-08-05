class_name NPCInputComponent extends InputComponent

@export var nav_agent: NavigationAgent3D
@export var body: Node3D

func update() -> void:
	if nav_agent == null or body == null:
		return
	if nav_agent.is_navigation_finished():
		move_dir = Vector2.ZERO
		return
	var next_pos := nav_agent.get_next_path_position()
	var to_target := next_pos - body.global_position
	move_dir = Vector2(to_target.x, to_target.z).normalized()
