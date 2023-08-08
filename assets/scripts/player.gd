extends CharacterBody2D

const SPEED = 50.0
const JUMP_VELOCITY = -250.0
const COYOTE_TIME = 0.2

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var timeSinceLeftGround: float = 0.0

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if is_on_floor():
		timeSinceLeftGround = 0.0
	else:
		timeSinceLeftGround += delta

	if Input.is_action_just_pressed("jump") and can_jump():
		velocity.y = JUMP_VELOCITY
		timeSinceLeftGround = 10

	var direction = Input.get_axis("left", "right")
	if direction:
		$Texture.flip_h = direction > -1

		if is_on_floor():
			$Texture.play("walk")

		velocity.x = direction * SPEED
	else:
		$Texture.play("idle")
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func can_jump() -> bool:
	return is_on_floor() or timeSinceLeftGround < COYOTE_TIME
