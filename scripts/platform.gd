extends StaticBody2D

func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	position.x -= Global.bg_speed * delta * 10
	
	if position.x < -100:
		queue_free()		# kill self :( when off screen
	
