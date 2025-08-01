extends Node2D

var height = 0
var rng = RandomNumberGenerator.new()
@onready var platform = preload("res://scenes/platform.tscn")
var spawn_speed = 1.2

func _ready() -> void:
	# populates screen with platforms
	for i in range(7):
		create_platform(250 + i * 150)
		
	set_spawn_speed(spawn_speed)
	$spawn_timer.start()


func _on_timer_timeout() -> void: # spawn timer times out
	create_platform(1250)
	

func create_platform(xcoord):
	# generates psuedo random platform given x coord
	height = (height + 1) % 3

	var p = platform.instantiate()
	p.position = Vector2(xcoord + randi_range(0, 40), 220 + 100 * height + rng.randi_range(-20, 40))
	add_child(p)


func set_spawn_speed(speed):
	$spawn_timer.wait_time = speed 
