class_name PlayerController extends CharacterBody3D

var _input_dir : Vector2 = Vector2.ZERO
var _movement_velocity : Vector3 = Vector3.ZERO
var speed : float = 7.0
var acceleration : float = 0.2
var deceleration : float = 0.6

@onready var camera = $CameraController/Camera3D

const base_fov : float = 75.0
const fov_change : float = 1.5

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	_input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	var current_velocity = Vector2(_movement_velocity.x,_movement_velocity.z)
	var direction = (transform.basis * Vector3(_input_dir.x, 0, _input_dir.y)).normalized()
	
	if direction:
		current_velocity = lerp(current_velocity, Vector2(direction.x, direction.z) * speed, acceleration)
	else:
		current_velocity = current_velocity.move_toward(Vector2.ZERO, deceleration)
	
	_movement_velocity = Vector3(current_velocity.x, velocity.y, current_velocity.y)
	
	velocity = _movement_velocity
	
	# FOV
	var velocity_clamped = clamp(velocity.length(), 0.5, speed * 2)
	var target_fov = base_fov + fov_change * velocity_clamped
	camera.fov = lerp(camera.fov, target_fov, delta * 8.0)
	
	move_and_slide()

func update_rotation(rotation_input) -> void:
	global_transform.basis = Basis.from_euler(rotation_input)
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("dev_exit"):
		get_tree().quit()
