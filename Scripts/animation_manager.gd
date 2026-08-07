class_name AnimationManager extends Node

signal cast_spell_finished
signal cast_shoot_finished

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
	animation_player.play("Rig_Medium_MovementBasic/Jump_Idle")
func play_dead() -> void:
	animation_player.play("Rig_Medium_General/Death_A")
func play_cast_spell() -> void:
	animation_player.play("Rig_Medium_CombatRanged/Ranged_Magic_Spellcasting")
func play_cast_shoot() -> void:
	animation_player.play("Rig_Medium_CombatRanged/Ranged_Magic_Shoot")
