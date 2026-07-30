class_name WeaponStateRight extends Node

var weapon_controller : WeaponControllerRight

func _ready() -> void:
	var parent = get_parent()
	if parent and parent is WeaponStateMachineRight:
		weapon_controller = parent.weapon_controller
