class_name WeaponState extends Node

var weapon_controller : WeaponController

func _ready() -> void:
	var parent = get_parent()
	if parent and parent is WeaponStateMachine:
		weapon_controller = parent.weapon_controller
