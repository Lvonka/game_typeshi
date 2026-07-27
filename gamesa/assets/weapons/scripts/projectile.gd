class_name Projectile extends Area3D #change to RayCast3D lenght = (speed * get_physics_process_delta_time())

var velocity : Vector3
var damage : float

func _ready() -> void:
	body_entered.connect((_on_body_entered))
	
	get_tree().create_timer(3.0).timeout.connect(queue_free)


func _physics_process(delta: float) -> void:
	#global_position += velocity * delta
	var space_state = get_world_3d().direct_space_state
	var start_pos = global_position
	var end_pos = global_position + velocity * delta
	
	var query = PhysicsRayQueryParameters3D.create(start_pos, end_pos)
	query.collision_mask = 1
	var result = space_state.intersect_ray(query)
	
	if result:
		global_position = result.position
		_on_body_entered(result.collider)
		return
	
	global_position = end_pos
	
func setup(vel: Vector3, dmg: float) -> void:
	velocity = vel
	damage = dmg
	
func _on_body_entered(body: Node3D) -> void:
	print("Projectile HIT: ", body.name, " at ", global_position)
	#_spawn_impact_marker(global_position)
	queue_free()
