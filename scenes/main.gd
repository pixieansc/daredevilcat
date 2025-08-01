extends Node2D

@onready var run_timer = $stage_timer

func _ready() -> void:
	start_runner()

func _process(delta: float) -> void:
	#print(Global.bg_speed)
	$ui/time.text = "time left: %02d:%02d" % [int(run_timer.time_left / 60), int(run_timer.time_left) % 60]
	
	if Input.is_action_just_pressed("debug"):
		start_runner()
	
func _on_stage_timer_timeout() -> void:
	# start boss fight 
	create_tween().tween_property($devil, "position:x", 100, 1).set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_OUT)
	Global.bg_speed = 25
	$platform_spawn.spawn_speed = 2.5
	
	
func start_runner():
	# controlls speed of runner
	Global.loop += 1 # keeps track of number of loops
	run_timer.start(45 - (Global.loop * 5))
	
	create_tween().tween_property($devil, "position:x", -250, 1).set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_OUT)
	create_tween().tween_property(Global, "bg_speed", 50, run_timer.wait_time - 1).set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_IN)
	$platform_spawn.spawn_speed = 2.3
	
