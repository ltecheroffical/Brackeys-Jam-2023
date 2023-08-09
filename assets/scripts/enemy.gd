extends CharacterBody2D


@onready var sprite = $Texture

@export var speed = 30

@export_category("Positions")
@export var position_1 = Vector2.ZERO
@export var position_2 = Vector2.ZERO

var cur_waypoint = -1
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _process(_delta):
	if global_position == get_waypoint():
		change_direction()
		await get_tree().physics_frame


func _physics_process(delta):
	var collision = get_last_slide_collision()
	global_position = global_position.move_toward(get_waypoint(), speed * delta)
	
	
	if collision and collision.get_collider():
		var body = collision.get_collider()
		
		if body.is_in_group("player"):
			body.hit()
	
	move_and_slide()


func change_direction():
	sprite.flip_h = !sprite.flip_h
	cur_waypoint *= -1


func get_waypoint():
	if cur_waypoint == 1:
		return position_1
	else:
		return position_2


func _on_stomp_detector_body_entered(body):
	if body.is_in_group("player"):
		$Texture.scale.y = 0.5
		$AnimationPlayer.play("die")
