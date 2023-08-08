extends CanvasLayer

@export var heart_scene: PackedScene
@export var health := 4
@onready var health_bar := $TopPanel/HealthBar

func _ready() -> void:
	for i in range(health):
		_increment_health(false)

func _increment_health(is_set_health := true):
	var heart := heart_scene.instantiate()
	health_bar.add_child(heart)
	if is_set_health:
		health += 1

func _decrement_health(is_set_health := true):
	if health > 0:
		var heart := health_bar.get_child(0)
		health_bar.remove_child(heart)
		if is_set_health:
			health -= 1
	else:
		get_tree().reload_current_scene()

func _on_player_healed(amount: int) -> void:
	for i in range(amount):
		_increment_health()

func _on_player_damaged(amount: int) -> void:
	for i in range(amount):
		_decrement_health()
