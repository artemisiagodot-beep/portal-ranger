extends CharacterBody3D
class_name Fireball

@export var speed: float = 20.0
@export var damage: float = 25.0
@export var lifetime: float = 5.0
@export var explosion_scene: PackedScene

var direction: Vector3 = Vector3.FORWARD

func _ready() -> void:
	var timer := get_tree().create_timer(lifetime)
	timer.timeout.connect(queue_free)

func launch(from_position: Vector3, target_direction: Vector3) -> void:
	global_position = from_position
	direction = target_direction.normalized()
	look_at(global_position + direction, Vector3.UP)

func _physics_process(delta: float) -> void:
	velocity = direction * speed
	var collision := move_and_collide(velocity * delta)

	if collision:
		_on_hit(collision)

func _on_hit(collision: KinematicCollision3D) -> void:
	var collider := collision.get_collider()
	if collider.has_method("take_damage"):
		collider.take_damage(damage)
	_explode()

func _explode() -> void:
	if explosion_scene:
		var explosion := explosion_scene.instantiate()
		get_tree().current_scene.add_child(explosion)
		explosion.global_position = global_position
		explosion.blast()
	queue_free()
