extends Area2D

var vertical = true

func _ready():
	if vertical:
		$AnimatedSprite2D.flip_v = false
		scale = Vector2(9, 9)
		rotation = 0

	fire()


func _process(delta: float) -> void:
	if vertical:
		position.x -= Global.bg_speed * delta * 10


func fire():
	$AnimatedSprite2D.play("start")
	await get_tree().create_timer(1).timeout
	
	$CollisionShape2D.set_deferred("disabled", false)
	$AnimatedSprite2D.play("default")
	await get_tree().create_timer(0.5).timeout
	
	$CollisionShape2D.set_deferred("disabled", true)
	$AnimatedSprite2D.play("end")
	await get_tree().create_timer(0.4).timeout
	
	queue_free()
