extends StaticBody2D

# defines default behavior for platforms

func _ready() -> void:
	pass
	

func _initiate(size):
	$CollisionShape2D.shape.set_size(Vector2(28 + size * 30, 4))
	
	if size == 0:
		$CollisionShape2D.position.y = 4
	
	match size:
		0: $AnimatedSprite2D.play("short")
		1: $AnimatedSprite2D.play("med")
		2: $AnimatedSprite2D.play("long")

func _process(delta: float) -> void:
	position.x -= Global.bg_speed * delta * 10
	
	if position.x < -300:
		queue_free()		# kill self :( when off screen
	
