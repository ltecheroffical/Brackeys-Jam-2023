extends CharacterBody2D


@onready var sprite = $Texture


@export var speed = 100

@export_category("Positions")
@export var position_1 = Vector2.ZERO
@export var position_2 = Vector2.ZERO


var current_waypoint = Vector2.ZERO


var direction = 1
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _ready():
	current_waypoint = position_2


func _physics_process(delta):
	for i in range(get_slide_collision_count()):
		var collision = get_slide_collision(i)
		if collision.normal.x > 0:
			return "left"
		elif collision.normal.x < 0:
			return "right"
		
	if not is_on_floor():
		velocity.y += gravity * delta
	
	
	var collision = get_last_slide_collision()
	
	if collision and collision.get_collider():
		var body = collision.get_collider()
		
		if body.is_in_group("player"):
			body.hit()
	
	move_and_slide()


func change_direction():
	sprite.flip_h = !sprite.flip_h
	direction *= -1
