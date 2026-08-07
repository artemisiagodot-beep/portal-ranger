extends Node3D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func blast() -> void:
	animation_player.play("explosion")
