extends ParallaxBackground

func _process(delta: float) -> void:
	scroll_offset.x -= Global.bg_speed * delta
