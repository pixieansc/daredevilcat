extends StaticBody2D

var ember = preload("res://scenes/ember.tscn")

var health = 1000
var rng = RandomNumberGenerator.new()

var is_attacking = false
var attack = 1


func _ready():
	$AnimatedSprite2D.play("blue")


func start():
	get_parent().get_node("ui/devil_health").value = health
	_on_atk_time_timeout()
	
func take_damage():
	$AnimationPlayer.play("flash")
	health -= 15
	get_parent().get_node("ui/devil_health").value = health
	
	if health <= 0:
		# boss dead !!!
		Global.loop += 1
		$atk_time.stop()
		$atk_interval.stop()
		get_parent().start_runner()
	

func _on_atk_time_timeout() -> void:
	#take a break
	$atk_interval.stop()
	await get_tree().create_timer(5).timeout
	
	#plan next attack
	# attack = rng.randi_range(1, 3)
	$atk_time.start() #start timer again
	$atk_interval.start()


func _on_atk_interval_timeout() -> void:
	match attack:
		1: ember_fall()


func ember_fall():
	var e = ember.instantiate()
	e.position = Vector2(600 + rng.randi_range(0, 2) * 300, -100)
	get_parent().add_child(e)
