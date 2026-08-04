class_name StateMachine extends Node

enum State { IDLE, WALK }

@onready var input_component: InputComponent = %InputComponent
@onready var movement_component: MovementComponent = %MovementComponent
@onready var animation_manager: AnimationManager = %AnimationManager

var state: State = State.IDLE

signal state_changed(old_state: State, new_state: State)

const MINIMUM_MOVE := 0.01

func _ready() -> void:
	_enter_state(state)

func _physics_process(_delta: float) -> void:
	var next_state := _get_next_state()
	if next_state != state:
		_exit_state(state)
		var old_state := state
		state = next_state
		_enter_state(state)
		state_changed.emit(old_state, state)

func _get_next_state() -> State:
	#avoiding some unwanted triggers
	if input_component.move_dir.length_squared() > MINIMUM_MOVE:
		return State.WALK
	return State.IDLE

func _enter_state(new_state: State) -> void:
	match new_state:
		State.IDLE:
			animation_manager.play_idle()
		State.WALK:
			animation_manager.play_walk()

func _exit_state(_old_state: State) -> void:
	pass

func get_state_name() -> String:
	return State.keys()[state]
