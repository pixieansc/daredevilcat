extends Area2D

var type = 0


func _ready():
	match type:
		0: $AnimatedSprite2D.play("heart")
		1: $AnimatedSprite2D.play("atk")
		
	scale = Vector2(1, 1) if type == 1 else Vector2(0.75, 0.75)


func _on_area_entered(area: Area2D) -> void:
	if area.get_parent().name == "cat":
		Global.success_sound()
		set_deferred("monitoring", false)
		
		var cat = area.get_parent()
		
		if type == 0:
			cat.get_parent().get_node("status").add_heart(cat.health < 9)
			
			if cat.health < 18:
				cat.health += 1
		elif type == 1:
			cat.power += 5
			cat.get_parent().get_node("status").add_attack("+5")
			
		var tw = create_tween().tween_property(self, "scale", Vector2.ZERO, 0.25).set_trans(Tween.TRANS_QUINT)
		await tw.finished
		
		queue_free()
		
