extends CharacterBody2D

var bullet = preload("res://scenes/bullet.tscn")

var SPEED = 500
const JUMP_VELOCITY = -600.0
const DASH = 2.5
const FRICTION = 0.5
const ACC = 0.25

var jump_count = 0
var is_dashing = false
var is_shooting = false

var health = 3

func _physics_process(delta: float) -> void: #movement of cat !!
	position.x -= Global.bg_speed * delta * 10

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		jump_count = 1
	elif Input.is_action_just_pressed("jump") and jump_count < 2:
		velocity.y = JUMP_VELOCITY
		jump_count = 2

	if Input.is_action_just_released("jump") and velocity.y < 0.0:
		velocity.y *= 0.5

	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta * 1.2
		
	# left right movement
	var direction := Input.get_axis("left", "right")
		
	if direction and not is_dashing:		
		velocity.x = lerp(velocity.x, direction * SPEED, ACC)
		$anim.flip_h = direction < 0
		
		if direction < 0:  # so walking left isn't faster
			position.x += Global.bg_speed * delta * 10	
	else:
		velocity.x = lerp(velocity.x, 0.0, FRICTION)

	# dashes :0
	if Input.is_action_just_pressed("dash") and not is_dashing:
		is_dashing = true
		await get_tree().create_timer(0.1, true).timeout
		is_dashing = false
		
	if is_dashing:
		velocity.x = SPEED * DASH if not $anim.flip_h else - (SPEED * DASH)
		velocity.y = 0

	# gun !!!
	if not is_shooting and Input.is_action_just_pressed("gun") and velocity.y == 0:
		shoot()
		
	# animation!
	if is_dashing: 
		$anim.play("dash")
	elif velocity.y != 0:
		$anim.play("jump")
	elif not direction:
		if is_shooting: $anim.play("idle_gun")
		elif $anim.animation != "idle_gun": $anim.play("idle")
	else:
		if is_shooting: $anim.play("run_gun")
		elif $anim.animation != "run_gun": $anim.play("run")
		
	move_and_slide()
	
func shoot():
	is_shooting = true
	
	var b = bullet.instantiate()
	b.position = Vector2(position.x + 30 if not $anim.flip_h else position.x - 20, position.y + 20)
	b.direction = Vector2.RIGHT if not $anim.flip_h else Vector2.LEFT
	b.speed = SPEED + 100 
	get_parent().add_child(b)
	
	await get_tree().create_timer(0.1).timeout
	is_shooting = false


func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("death") or area.get_parent().is_in_group("death"):
		health -= 1
		get_parent().get_node("status").rm_heart()
		
		# respawn & immunity frames
		set_physics_process(false)
		$hitbox.set_deferred("monitoring", false) 
		
		$anim.play("jump")
		$AnimationPlayer.play("flash")
		position = Vector2(1000, 150)
		velocity = Vector2.ZERO
		await get_tree().create_timer(1).timeout
		
		$hitbox.set_deferred("monitoring", true) 
		set_physics_process(true)
			
		if health == 0: 
			health = 3 
			get_parent().get_node("status").respawn()
			#DEAThHHHH
