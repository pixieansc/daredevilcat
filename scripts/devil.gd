extends StaticBody2D

@export var health = 1000

func _ready():
	$AnimatedSprite2D.play("blue")
	
func start():
	get_parent().get_node("ui/devil_health").value = health
	
func take_damage():
	$AnimationPlayer.play("flash")
	health -= 15
	get_parent().get_node("ui/devil_health").value = health
	
	if health <= 0:
		# dead !!!
		Global.loop += 1
		get_parent().start_runner()
	
