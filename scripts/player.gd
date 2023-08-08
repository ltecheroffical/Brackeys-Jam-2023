extends CharacterBody2D
class_name Player

@export var speed = 200.0
@export var jump_velocity = -250.0
@export var coyote_time = 0.2

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var air_time: float = 0.0

signal healed(amount: int)
signal damaged(amount: int)

@onready var timer := $Timer

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if is_on_floor():
		air_time = 0.0
	else:
		air_time += delta

	if Input.is_action_just_pressed("move_jump") and can_jump():
		velocity.y = jump_velocity
		air_time = 10

	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		$Texture.flip_h = direction > -1

		if is_on_floor():
			$Texture.play("walk")

		velocity.x = direction * speed
	else:
		$Texture.play("idle")
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()

func can_jump() -> bool:
	return is_on_floor() or air_time < coyote_time

func hit(amount := 1):
	if not timer.time_left:
		timer.start()
		emit_signal("damaged", amount)

func heal(amount := 1):
	emit_signal("healed", amount)
