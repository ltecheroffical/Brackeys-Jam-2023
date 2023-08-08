extends Area2D

signal picked_up(type: String)

@export_group("Pickup Properties", "pickup_")
@export var pickup_resource: CanvasTexture

@onready var animation_player := $AnimationPlayer

func _ready() -> void:
	await get_tree().create_timer(1).timeout
	_on_player_pick_up()

func _on_player_pick_up():
	emit_signal("picked_up", pickup_resource.resource_name)
	animation_player.play("pickup")
