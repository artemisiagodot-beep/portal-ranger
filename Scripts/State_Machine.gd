class_name StateMachine
extends Node

enum State { IDLE, WALK, JUMP_START, IN_AIR, LANDING }

@onready var input_component: InputComponent = %InputComponent
@onready var movement_component: MovementComponent = %MovementComponent
@onready var animation_manager: AnimationManager = %AnimationManager

var state: State = State.IDLE
signal state_changed(old_state: State, new_state: State)

const MINIMUM_MOVE := 0.01
const LANDING_DURATION := 0.25

var landing_timer := 0.0

func _ready() -> void:
	_enter_state(state)

func _physics_process(delta: float) -> void:
	if landing_timer > 0.0:
		landing_timer -= delta

	var next_state := _get_next_state()
	if next_state != state:
		_exit_state(state)
		var old_state := state
		state = next_state
		_enter_state(state)
		state_changed.emit(old_state, state)

func _get_next_state() -> State:
	var on_floor := movement_component.body.is_on_floor()

	match state:
		State.IDLE, State.WALK:
			if input_component.jump_pressed and on_floor:
				return State.JUMP_START
			if not on_floor:
				return State.IN_AIR
			if input_component.move_dir.length_squared() > MINIMUM_MOVE:
				return State.WALK
			return State.IDLE

		State.JUMP_START:
			if not on_floor:
				return State.IN_AIR
			return state

		State.IN_AIR:
			if on_floor:
				return State.LANDING
			return state

		State.LANDING:
			if landing_timer <= 0.0:
				if input_component.move_dir.length_squared() > MINIMUM_MOVE:
					return State.WALK
				return State.IDLE
			return state

	return state

func _enter_state(new_state: State) -> void:
	match new_state:
		State.IDLE:
			animation_manager.play_idle()
		State.WALK:
			animation_manager.play_walk()
		State.JUMP_START:
			animation_manager.play_jump()
			movement_component.wants_jump = true
		State.IN_AIR:
			animation_manager.play_in_air()
		State.LANDING:
			animation_manager.play_landing()
			landing_timer = LANDING_DURATION

func _exit_state(_old_state: State) -> void:
	pass

func get_state_name() -> String:
	return State.keys()[state]
