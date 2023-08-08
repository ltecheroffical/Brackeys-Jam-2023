extends CharacterBody2D


@export var speed = 400.0

var direction = 1


func _physics_process(delta):
	collide_with_wall()
	velocity.x = speed * direction * delta
	
	move_and_slide()

func collide_with_wall():
	if is_on_wall():
		change_direction()

func change_direction():
	direction *= -1
