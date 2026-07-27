class_name WeaponController extends Node

@export var camera : Camera3D
@export var current_weapon : Weapon
@export var weapon_model_parent : Node3D
@export var weapon_state_chart : StateChart

var current_weapon_model : Node3D
var current_ammo : int

func _ready() -> void:
	if current_weapon:
		spawn_weapon_model()
		current_ammo = current_weapon.max_ammo

func spawn_weapon_model():
	if current_weapon_model:
		current_weapon_model.queue_free()
		
	if current_weapon.weapon_model:
		current_weapon_model = current_weapon.weapon_model.instantiate()
		weapon_model_parent.add_child(current_weapon_model)
		current_weapon_model.position = current_weapon.weapon_position
		
func can_fire() -> bool:
	return current_ammo > 0
	
func fire_weapon() -> void:
	if can_fire():
		current_ammo -= 1
		print("Ammo: ", current_ammo)
		
		_spawn_projectile()
		
func _spawn_projectile() -> void:
	if not current_weapon.projectile_scene:
		print("No projectile scene assigned")
		return
	
	if not camera:
		print("Camera not assigned")
		return
		
	var projectile = current_weapon.projectile_scene.instantiate() as Projectile
	get_tree().current_scene.add_child(projectile)
	
	projectile.global_position = camera.global_position
	
	var forward = -camera.global_transform.basis.z
	var velocity = forward * current_weapon.projectile_speed
	projectile.look_at(projectile.global_position + forward, Vector3.UP)
	
	projectile.setup(velocity, current_weapon.damage)
