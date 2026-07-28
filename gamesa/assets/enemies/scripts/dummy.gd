class_name Dummy extends EnemySystem

@onready var health_component : HealthComponent = $HealthComponent

func _ready() -> void:
	#health_component.died.connect(_on_health_component_died)
	pass
	
	
func _on_health_component_died() -> void:
	print(name, " destroyed")
	queue_free()
