extends CanvasLayer

@export var heart_scene: PackedScene
@export var health := 4
@onready var health_bar := $TopPanel/HealthBar

func _ready() -> void:
	for i in range(health):
		_increment_health(false)

func _on_pickup_picked_up(type) -> void:
	if type == "Health":
		_increment_health()

func _increment_health(is_set_health := true):
	var heart := heart_scene.instantiate()
	health_bar.add_child(heart)
	health += 1
