extends WeaponStateLeft

func _on_firing_state_left_state_entered() -> void:
	if not weapon_controller:
		return
		
	weapon_controller.fire_weapon()
	
func _on_firing_state_left_state_processing(delta: float) -> void:
	if not weapon_controller:
		return

		
	if weapon_controller.current_ammo <= 0:
		weapon_controller.weapon_state_chart.send_event("onEmptyLeft")
		return
		
	weapon_controller.weapon_state_chart.send_event("onIdleLeft")
