class_name AnimationManager extends Node

@onready var animation_player: AnimationPlayer = $"../AnimationPlayer"

func play_idle() -> void:
	animation_player.play("Rig_Medium_General/Idle_A")
func play_walk() -> void:
	animation_player.play("Rig_Medium_MovementBasic/Walking_A")
func play_jump() -> void:
	animation_player.play("Rig_Medium_MovementBasic/Jump_Start")
func play_landing() -> void:
	animation_player.play("Rig_Medium_MovementBasic/Jump_Land")
func play_in_air() -> void:
	animation_player.play("Rig_Medium_General/Spawn_Air")
