extends Label

func _ready():
	pivot_offset = Vector2(size.x / 2, size.y / 2)
	animate()
	
	
func animate():
	var tw = create_tween().set_parallel(true)
	tw.tween_property(self, "position:y", position.y - 15, 0.5).set_ease(Tween.EASE_IN)
	tw.tween_property(self, "scale", Vector2.ZERO, 0.25).set_ease(Tween.EASE_IN).set_delay(0.2)
	
	await tw.finished
	queue_free() # kill number !
