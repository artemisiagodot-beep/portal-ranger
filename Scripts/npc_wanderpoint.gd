class_name NPCWanderComponent extends Node

@export var nav_agent: NavigationAgent3D

var _nav_regions: Array[NavigationRegion3D] = []

func _ready() -> void:
	for node in get_tree().get_nodes_in_group("nav_regions"):
		if node is NavigationRegion3D:
			_nav_regions.append(node)
	_pick_new_target()
	nav_agent.navigation_finished.connect(_pick_new_target)

func _pick_new_target() -> void:
	if _nav_regions.is_empty():
		return
	var region: NavigationRegion3D = _nav_regions.pick_random()
	var point := NavigationServer3D.region_get_random_point(region.get_rid(), 1, false)
	nav_agent.target_position = point
