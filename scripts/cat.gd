extends CharacterBody2D


const SPEED = 250.0
const JUMP_VELOCITY = -500.0
var jump_count = 0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		jump_count = 1
	elif Input.is_action_just_pressed("jump") and jump_count == 1:
		velocity.y = JUMP_VELOCITY
		jump_count = 2

	if Input.is_action_just_released("jump") and velocity.y < 0.0:
		velocity.y *= 0.5


	# left right movement
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
		$anim.flip_h = direction < 0
		
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# animation!
	if velocity == Vector2(0,0):
		$anim.play("idle")
	elif velocity.y == 0:
		$anim.play("run")
	else:
		$anim.play("jump")
		
	move_and_slide()

	
