extends Node2D

var heart = preload("res://scenes/heart.tscn")

func _ready() -> void:
	respawn()

func add_heart():
	var h = heart.instantiate()	
	$heart_box.add_child(h)
	$heart_box.move_child(h, 0)
	
	h.get_node("AnimatedSprite2D").scale = Vector2.ZERO
	create_tween().tween_property(h.get_node("AnimatedSprite2D"), "scale", Vector2(4, 4), 0.5).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)


func rm_heart():
	if $heart_box.get_child_count() - 1 >= 0:
		var rm = $heart_box.get_child(0)
		
		var tw = create_tween().tween_property(rm, "scale", Vector2.ZERO, 0.5).set_trans(Tween.TRANS_QUINT)
		await tw.finished
		
		$heart_box.remove_child(rm)
		rm.queue_free()

	
func respawn():
	for i in range(3):
		add_heart()
	
