extends Area2D

var speed = 700
var direction = Vector2.LEFT

func _ready() -> void:
	$AnimatedSprite2D.play("default")


func _process(delta: float) -> void:
	position += direction * speed * delta
	position.x -= Global.bg_speed * delta * 10
	
	if position.x < 10:
		queue_free() # kill if off screen


func _on_body_entered(body: Node2D) -> void:
	body.take_damage()
	queue_free()
