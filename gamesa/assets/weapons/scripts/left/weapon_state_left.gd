class_name WeaponStateLeft extends Node

var weapon_controller : WeaponControllerLeft

func _ready() -> void:
	var parent = get_parent()
	if parent and parent is WeaponStateMachineLeft:
		weapon_controller = parent.weapon_controller
