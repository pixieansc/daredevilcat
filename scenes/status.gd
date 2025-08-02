extends Node2D

var heart = preload("res://scenes/heart.tscn")

func _ready() -> void:
	respawn()

func add_heart():
	var h = heart.instantiate()
	$heart_box.add_child(h)
	

func rm_heart():
	var rm = $heart_box.get_child($heart_box.get_child_count() - 1)
	$heart_box.remove_child(rm)
	rm.queue_free()

	
func respawn():
	for i in range(3):
		add_heart()
	
