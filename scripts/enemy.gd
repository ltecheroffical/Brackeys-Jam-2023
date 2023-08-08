extends CharacterBody2D
class_name Enemy

@onready var sprite := $Sprite2D
@onready var raycast := $RayCast2D
@export var speed := 100
var direction := 1
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

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
		var body: Object = collision.get_collider()
		if body is Player:
			body.hit()

func change_direction():
	sprite.flip_h = !sprite.flip_h
	direction *= -1
	raycast.target_position *= Vector2(-1, 1)
