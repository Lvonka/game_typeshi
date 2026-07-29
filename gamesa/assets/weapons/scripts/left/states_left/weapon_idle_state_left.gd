extends WeaponStateLeft

func _on_idle_state_left_state_processing(delta: float) -> void:
	if not weapon_controller:
		return
		
	if Input.is_action_just_pressed("shoot_left") and weapon_controller.can_fire():
		weapon_controller.weapon_state_chart.send_event("onFiringLeft")
		
	if weapon_controller.current_ammo <= 0:
		weapon_controller.weapon_state_chart.send_event("onEmptyLeft")
