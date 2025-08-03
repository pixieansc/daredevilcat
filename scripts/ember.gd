extends Area2D


func _process(delta: float) -> void:
	position.y += 380 * delta 
	position.x -= Global.bg_speed * delta * 10
	
	if position.y > 750:
		queue_free()
	
