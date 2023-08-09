extends CharacterBody2D
class_name Player


signal healed(amount: int)
signal damaged(amount: int)


const SPEED = 50.0
const DASH_SPEED = 1000

const JUMP_VELOCITY = 450.0
const COYOTE_TIME = 0.25


var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var timeSinceLeftGround: float = 0.0

var dash_pressed = false
var dash_direction = 0


@onready var damage_timer := $DamageTimer


func _process(_delta):
	if not Input.is_action_pressed("dash") and dash_pressed:
		dash_pressed = false


func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
		
		$Texture.play("idle")
	
	
	if not $DashTime.is_stopped():
		velocity.x = dash_direction * DASH_SPEED
		$Texture.modulate = Color(255, 255, 255, 1)
	else:
		$Texture.modulate = Color.WHITE
	
	
	if is_on_floor():
		timeSinceLeftGround = 0.0
	else:
		timeSinceLeftGround += delta

	if Input.is_action_just_pressed("jump") and can_jump():
		velocity.y = -JUMP_VELOCITY
		timeSinceLeftGround = 10

	var direction = Input.get_axis("left", "right")
	if direction and $DashTime.is_stopped():
		$Texture.flip_h = direction > -1
		
		if Input.is_action_pressed("dash") and not dash_pressed:
			$DashTime.start()
			dash_direction = direction
		
			dash_pressed = true
		else:
			if is_on_floor():
				$Texture.play("walk")

			velocity.x = direction * SPEED
	else:
		$Texture.play("idle")
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func can_jump() -> bool:
	return is_on_floor() or timeSinceLeftGround < COYOTE_TIME


func hit(amount := 1):
	if damage_timer.is_stopped():
		damage_timer.start()
		emit_signal("damaged", amount)

func heal(amount := 1):
	emit_signal("healed", amount)
