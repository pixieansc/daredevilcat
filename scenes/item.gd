extends Area2D

var type = 0


func _ready():
	match type:
		0: $AnimatedSprite2D.play("heart")


func _on_area_entered(area: Area2D) -> void:
	if area.get_parent().name == "cat":
		var cat = area.get_parent()
		
		if type == 0:
			cat.get_parent().get_node("status").add_heart()
			cat.health += 1
		
		queue_free()
		
