extends Node2D

# spawns platforms automatically based on timer !!

var height = 0
var rng = RandomNumberGenerator.new()
@onready var platform = preload("res://scenes/platform.tscn")
@export var spawn_speed = 2.5

func _ready() -> void:
	# populates screen with platforms
	for i in range(3):
		create_platform(250 + i * 600)
		
	$spawn_timer.start(spawn_speed)


func _on_timer_timeout() -> void: # spawn timer times out
	create_platform(1500)
	$spawn_timer.start(spawn_speed)
	

func create_platform(xcoord):
	# generates psuedo random platforms given x coord
	height = (height + 1) % 2

	var p = platform.instantiate()
	var p_size = rng.randi_range(1, 2)
	p._initiate(p_size) # initiate long
	p.position = Vector2(xcoord + randi_range(-70, 70), 225 + 200 * height)
	add_child(p)
	
	var p_short = platform.instantiate()
	p_size = rng.randi_range(0, 1)
	p_short._initiate(p_size) # initiate random short or medium
	p_short.position = Vector2(p.position.x + 600 - (p_size * 50), p.position.y + rng.randi_range(-25, 25))
	add_child(p_short)
