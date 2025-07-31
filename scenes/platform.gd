extends StaticBody2D

func _process(delta: float) -> void:
	position.x -= Global.speed * delta * 8
	
	if position.x < -100:
		queue_free()		# kill self :( when off screen
	
