extends CharacterBody3D
@onready var animation_manager: AnimationManager = $AnimationManager

func _physics_process(delta: float) -> void:
	animation_manager.play_idle()
