class_name WeaponControllerLeft extends Node

@export var camera : Camera3D
@export var current_weapon : Weapon
@export var weapon_model_parent : Node3D
@export var weapon_state_chart : StateChart
@export var left_side_offset : Vector3 = Vector3(-0.5, -0.3, -0.5)

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
		#current_weapon_model.position.x += -0.5
		
		var pos = current_weapon.weapon_position
		pos.x = -abs(pos.x)
		current_weapon_model.position = pos
		
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
	projectile.global_transform = camera.global_transform
	
	
	#projectile.global_position = camera.global_position
	
	#projectile.global_transform.basis = camera.global_transform.basis
	
	#projectile.setup(velocity, current_weapon.damage)
	projectile.setup(current_weapon.projectile_speed, current_weapon.damage)
	
func _apply_damage_to_target(target : Node3D) -> void:
	var health_component = target.get_node_or_null("HealthComponent")
	
	if health_component and health_component.has_method("dake_damage"):
		health_component.take_damage(current_weapon.damage, get_parent())
