extends StaticBody2D

var ember = preload("res://scenes/ember.tscn")
var flame = preload("res://scenes/fire_col.tscn")
var damage = preload("res://scenes/dmg.tscn")

var health = 1000
var rng = RandomNumberGenerator.new()

var is_attacking = false
var attack = 1


func _ready():
	$AnimatedSprite2D.play("blue")


func start():
	get_parent().get_node("ui/devil_health").value = health
	_on_atk_time_timeout()
	
	
func take_damage(dmg):
	$AnimationPlayer.play("flash")
	
	health -= dmg
	get_parent().get_node("ui/devil_health").value = health
	
	var d = damage.instantiate()
	d.position = Vector2(10, -20)
	d.text = str(dmg)
	add_child(d)
	
	if health <= 10:
		# boss dead !!!
		Global.loop += 1
		$atk_time.stop()
		$atk_interval.stop()
		get_parent().start_runner()
	

func _on_atk_time_timeout() -> void:
	#take a break
	$atk_interval.stop()
	await get_tree().create_timer(3).timeout
	
	#plan next attack
	if health >= 50:
		attack = rng.randi_range(1, 3)
		$atk_time.start() #start timer again
		
		if attack == 1:
			$atk_interval.start(1)
			$atk_time.start(5)
		elif attack == 2 or attack == 3:
			$atk_interval.start(3)
			$atk_time.start(10)


func _on_atk_interval_timeout() -> void:
	match attack:
		1: ember_fall()
		2: flame_throw(true)
		3: flame_throw(false)


func ember_fall():
	var e = ember.instantiate()
	e.position = Vector2(700 + rng.randi_range(0, 2) * 300, -100)
	get_parent().add_child(e)
	

func flame_throw(vertical):
	var f = flame.instantiate()
	f.vertical = vertical
	
	if vertical:
		f.position = Vector2(800 + rng.randi_range(0, 2) * 200, 525)
	else: 
		f.position = Vector2(925, 350 + rng.randi_range(0, 1) * 200)
	
	
	get_parent().add_child(f)
