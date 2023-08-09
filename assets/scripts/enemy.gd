extends CharacterBody2D


@onready var sprite = $Sprite2D
@onready var raycast = $RayCast2D

@export var speed = 100

@export_category("Positions")
@export var position_1 = Vector2.ZERO
@export var position_2 = Vector2.ZERO

var direction = 1
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	var motion := Vector2()
	
	if raycast.is_colliding():
		change_direction()
		
	for i in range(get_slide_collision_count()):
		var collision = get_slide_collision(i)
		if collision.normal.x > 0:
			return "left"
		elif collision.normal.x < 0:
			return "right"
		
	if not is_on_floor():
		motion.y += gravity * delta
	
	motion.x = speed * direction
	var collision := move_and_collide(motion)
	
	if collision and collision.get_collider():
		var body = collision.get_collider()
		
		if body.is_in_group("player"):
			body.hit()


func change_direction():
	sprite.flip_h = !sprite.flip_h
	direction *= -1
	raycast.target_position *= Vector2(-1, 1)
