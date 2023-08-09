extends Area2D
class_name Pickup


signal picked_up(type: String)


@export_group("Pickup Properties", "pickup_")
@export var pickup_resource: CanvasTexture

@onready var animation_player := $AnimationPlayer
@onready var collision := $CollisionShape2D


func _on_body_entered(body: Player) -> void:
	emit_signal("picked_up", pickup_resource.resource_name)
	
	
	if pickup_resource.resource_name == "Health":
		body.heal()
	
	
	animation_player.play("pickup")
