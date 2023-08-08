extends CharacterBody2D

@onready var sprite := $Sprite2D
@export var speed := 100
var direction := 1
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	collide_with_wall()
	if not is_on_floor():
		velocity.y += gravity * delta
	velocity.x = speed * direction
	move_and_slide()

func collide_with_wall():
	if is_on_wall():
		change_direction()

func change_direction():
	sprite.flip_h = !sprite.flip_h
	direction *= -1
