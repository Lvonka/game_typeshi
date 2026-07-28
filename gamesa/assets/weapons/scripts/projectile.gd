class_name Projectile extends RayCast3D #change to RayCast3D lenght = (speed * get_physics_process_delta_time())

var velocity : Vector3
var damage : float
var speed : float

func _physics_process(delta: float) -> void:
	position += global_basis * Vector3.FORWARD * speed * delta
	target_position = Vector3.FORWARD * speed * delta
	force_raycast_update()
	var collider = get_collider()
	if is_colliding():
		global_position = get_collision_point()
		set_physics_process(false)
		print("HIT")
		cleanup()

#func setup(vel: Vector3, dmg: float) -> void:
#	velocity = vel
#	damage = dmg
	
func setup(spd: float, dmg: float) -> void:
	speed = spd
	damage = dmg
	
func cleanup() -> void:
	queue_free()
