class_name NPCInputComponent extends InputComponent

@export var nav_agent: NavigationAgent3D
@export var body: Node3D
@export var move_speed: float = 3.5

var safe_velocity_use: Vector3 = Vector3.ZERO

func _ready() -> void:
	if nav_agent == null:
		return
	nav_agent.avoidance_enabled = true
func update() -> void:
	if nav_agent == null or body == null:
		return
	if nav_agent.is_navigation_finished():
		move_dir = Vector2.ZERO
		return

	var next_pos: Vector3 = nav_agent.get_next_path_position()
	var desired_velocity: Vector3 = (next_pos - body.global_position).normalized() * move_speed
	nav_agent.set_velocity(desired_velocity)

	move_dir = Vector2(safe_velocity_use.x, safe_velocity_use.z).normalized()

func _on_navigation_agent_3d_velocity_computed(safe_velocity: Vector3) -> void:
	safe_velocity_use = safe_velocity
